import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../models/chat_models.dart';
import '../models/user_profile.dart';
import 'firebase_service.dart';
import 'auth_service.dart';

class MessagingService {
  static FirebaseFirestore get _db => FirebaseFirestore.instance;
  static FirebaseAuth get _auth => FirebaseAuth.instance;
  static const _uuid = Uuid();

  // Chat Rooms
  static Stream<List<ChatRoom>> getUserChatRooms() {
    if (!FirebaseService.isInitialized) {
      return const Stream.empty();
    }
    
    final user = _auth.currentUser;
    if (user == null) {
      return const Stream.empty();
    }

    return _db
        .collection('chat_rooms')
        .where('memberIds', arrayContains: user.uid)
        .snapshots()
        .map((snapshot) {
          final rooms = snapshot.docs
              .map((doc) => ChatRoom.fromMap({...doc.data(), 'id': doc.id}))
              .toList();
          rooms.sort((a, b) {
            final aTime = a.lastMessageAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            final bTime = b.lastMessageAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            return bTime.compareTo(aTime);
          });
          return rooms;
        });
  }

  // Public Groups Discovery
  static Stream<List<ChatRoom>> getPublicGroups() {
    if (!FirebaseService.isInitialized) {
      return const Stream.empty();
    }

    return _db
        .collection('chat_rooms')
        .where('type', isEqualTo: ChatType.group.name)
        .where('isPrivate', isEqualTo: false)
        .limit(100)
        .snapshots()
        .map((snapshot) {
          final groups = snapshot.docs
              .map((doc) => ChatRoom.fromMap({...doc.data(), 'id': doc.id}))
              .toList();
          groups.sort((a, b) {
            final aTime = a.lastMessageAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            final bTime = b.lastMessageAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            return bTime.compareTo(aTime);
          });
          return groups;
        });
  }

  static Future<ChatRoom> createGroupChat({
    required String name,
    required String description,
    required List<String> memberIds,
    String? imageUrl,
    bool isPrivate = false,
  }) async {
    if (!FirebaseService.isInitialized) {
      throw Exception('Firebase not initialized');
    }

    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    // Enforce mentor-only group creation
    final creatorProfile = await AuthService.getCurrentUserProfile();
    if (creatorProfile == null || creatorProfile.role != UserRole.mentor) {
      throw Exception('Only mentors can create support groups');
    }

    final chatRoom = ChatRoom(
      id: _uuid.v4(),
      name: name,
      description: description,
      imageUrl: imageUrl,
      type: ChatType.group,
      memberIds: [user.uid, ...memberIds],
      createdBy: user.uid,
      createdAt: DateTime.now(),
      isPrivate: isPrivate,
    );

    await _db
        .collection('chat_rooms')
        .doc(chatRoom.id)
        .set(chatRoom.toMap());

    return chatRoom;
  }

  static Future<ChatRoom> createPrivateChat(String targetUserId) async {
    if (!FirebaseService.isInitialized) {
      throw Exception('Firebase not initialized');
    }

    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    // Check if private chat already exists
    final existingChats = await _db
        .collection('chat_rooms')
        .where('type', isEqualTo: ChatType.private.name)
        .where('memberIds', arrayContains: user.uid)
        .get();

    for (final doc in existingChats.docs) {
      final chat = ChatRoom.fromMap({...doc.data(), 'id': doc.id});
      if (chat.memberIds.contains(targetUserId) && chat.memberIds.length == 2) {
        return chat;
      }
    }

    // Create new private chat
    final chatRoom = ChatRoom(
      id: _uuid.v4(),
      name: '', // Will be set based on participants
      type: ChatType.private,
      memberIds: [user.uid, targetUserId],
      createdAt: DateTime.now(),
    );

    await _db
        .collection('chat_rooms')
        .doc(chatRoom.id)
        .set(chatRoom.toMap());

    return chatRoom;
  }

  static Future<void> joinGroupChat(String chatRoomId) async {
    if (!FirebaseService.isInitialized) return;

    final user = _auth.currentUser;
    if (user == null) return;

    await _db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .update({
      'memberIds': FieldValue.arrayUnion([user.uid]),
    });
  }

  static Future<void> leaveGroupChat(String chatRoomId) async {
    if (!FirebaseService.isInitialized) return;

    final user = _auth.currentUser;
    if (user == null) return;

    await _db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .update({
      'memberIds': FieldValue.arrayRemove([user.uid]),
    });
  }

  // Messages
  static Stream<List<ChatMessage>> getChatMessages(String chatRoomId, {int limit = 50}) {
    if (!FirebaseService.isInitialized) {
      return const Stream.empty();
    }

    return _db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatMessage.fromMap({...doc.data(), 'id': doc.id}))
            .toList());
  }

  static Future<List<ChatMessage>> fetchOlderMessages({
    required String chatRoomId,
    required DateTime before,
    int limit = 50,
  }) async {
    if (!FirebaseService.isInitialized) return [];

    final snap = await _db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .startAfter([before.toIso8601String()])
        .limit(limit)
        .get();
    return snap.docs
        .map((doc) => ChatMessage.fromMap({...doc.data(), 'id': doc.id}))
        .toList();
  }

  static Future<void> sendMessage({
    required String chatRoomId,
    required String content,
    MessageType type = MessageType.text,
    String? replyToMessageId,
  }) async {
    if (!FirebaseService.isInitialized) return;

    final user = _auth.currentUser;
    if (user == null) return;

    // Get user profile for sender info
    final userProfile = await AuthService.getCurrentUserProfile();
    if (userProfile == null) return;

    final message = ChatMessage(
      id: _uuid.v4(),
      chatRoomId: chatRoomId,
      senderId: user.uid,
      senderName: userProfile.displayName,
      senderAvatar: userProfile.avatarUrl,
      content: content,
      type: type,
      createdAt: DateTime.now(),
      replyToMessageId: replyToMessageId,
    );

    // Add message to chat room
    await _db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .doc(message.id)
        .set(message.toMap());

    // Update last message timestamp
    await _db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .update({
      'lastMessageAt': DateTime.now().toIso8601String(),
    });
  }

  // Read state and unread count
  static Future<void> markRoomRead(String chatRoomId) async {
    if (!FirebaseService.isInitialized) return;
    final user = _auth.currentUser;
    if (user == null) return;
    await _db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('read_states')
        .doc(user.uid)
        .set({'lastReadAt': DateTime.now().toIso8601String()}, SetOptions(merge: true));
  }

  static Stream<int> getUnreadCount(String chatRoomId) {
    if (!FirebaseService.isInitialized) return const Stream.empty();
    final user = _auth.currentUser;
    if (user == null) return const Stream.empty();

    final roomRef = _db.collection('chat_rooms').doc(chatRoomId);
    final readRef = roomRef.collection('read_states').doc(user.uid);

    return readRef.snapshots().asyncMap((readSnap) async {
      final lastReadAtStr = (readSnap.data() ?? {})['lastReadAt'] as String?;
      final lastReadAt = lastReadAtStr != null ? DateTime.parse(lastReadAtStr) : DateTime.fromMillisecondsSinceEpoch(0);

      final newer = await roomRef
          .collection('messages')
          .where('createdAt', isGreaterThan: lastReadAt.toIso8601String())
          .get();
      // Exclude user's own messages
      final count = newer.docs.where((d) => (d.data()['senderId'] as String?) != user.uid).length;
      return count;
    });
  }

  // Typing indicators
  static Future<void> setTyping({required String chatRoomId, required bool isTyping}) async {
    if (!FirebaseService.isInitialized) return;
    final user = _auth.currentUser;
    if (user == null) return;
    await _db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('typing')
        .doc(user.uid)
        .set({'isTyping': isTyping, 'updatedAt': DateTime.now().toIso8601String()}, SetOptions(merge: true));
  }

  static Stream<List<String>> typingUsers(String chatRoomId) {
    if (!FirebaseService.isInitialized) return const Stream.empty();
    final user = _auth.currentUser;
    if (user == null) return const Stream.empty();

    return _db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('typing')
        .snapshots()
        .map((snap) => snap.docs
            .where((d) => (d.data()['isTyping'] == true) && d.id != user.uid)
            .map((d) => d.id)
            .toList());
  }

  static Future<void> addMessageReaction({
    required String chatRoomId,
    required String messageId,
    required String emoji,
  }) async {
    if (!FirebaseService.isInitialized) return;

    final user = _auth.currentUser;
    if (user == null) return;

    final messageRef = _db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .doc(messageId);

    // Get current reactions
    final messageDoc = await messageRef.get();
    if (!messageDoc.exists) return;

    final message = ChatMessage.fromMap({...messageDoc.data()!, 'id': messageId});
    final reactions = Map<String, List<String>>.from(message.reactions);

    // Add or remove user from reaction
    if (reactions.containsKey(emoji)) {
      final users = List<String>.from(reactions[emoji]!);
      if (users.contains(user.uid)) {
        users.remove(user.uid);
        if (users.isEmpty) {
          reactions.remove(emoji);
        } else {
          reactions[emoji] = users;
        }
      } else {
        users.add(user.uid);
        reactions[emoji] = users;
      }
    } else {
      reactions[emoji] = [user.uid];
    }

    // Update message
    await messageRef.update({
      'reactions': reactions,
    });
  }

  static Future<void> editMessage({
    required String chatRoomId,
    required String messageId,
    required String newContent,
  }) async {
    if (!FirebaseService.isInitialized) return;

    final user = _auth.currentUser;
    if (user == null) return;

    await _db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .doc(messageId)
        .update({
      'content': newContent,
      'editedAt': DateTime.now().toIso8601String(),
      'isEdited': true,
    });
  }

  static Future<void> deleteMessage({
    required String chatRoomId,
    required String messageId,
  }) async {
    if (!FirebaseService.isInitialized) return;

    final user = _auth.currentUser;
    if (user == null) return;

    // Check if user is the sender
    final messageDoc = await _db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .doc(messageId)
        .get();

    if (messageDoc.exists) {
      final message = ChatMessage.fromMap({...messageDoc.data()!, 'id': messageId});
      if (message.senderId == user.uid) {
        await _db
            .collection('chat_rooms')
            .doc(chatRoomId)
            .collection('messages')
            .doc(messageId)
            .delete();
      }
    }
  }

  // Chat Requests
  static Future<void> sendChatRequest({
    required String targetUserId,
    String? message,
  }) async {
    if (!FirebaseService.isInitialized) return;

    final user = _auth.currentUser;
    if (user == null) return;

    final userProfile = await AuthService.getCurrentUserProfile();
    if (userProfile == null) return;

    final chatRequest = ChatRequest(
      id: _uuid.v4(),
      requesterId: user.uid,
      requesterName: userProfile.displayName,
      requesterAvatar: userProfile.avatarUrl,
      targetUserId: targetUserId,
      message: message,
      status: ChatRequestStatus.pending,
      createdAt: DateTime.now(),
    );

    await _db
        .collection('chat_requests')
        .doc(chatRequest.id)
        .set(chatRequest.toMap());
  }

  static Stream<List<ChatRequest>> getChatRequests() {
    if (!FirebaseService.isInitialized) {
      return const Stream.empty();
    }

    final user = _auth.currentUser;
    if (user == null) {
      return const Stream.empty();
    }

    return _db
        .collection('chat_requests')
        .where('targetUserId', isEqualTo: user.uid)
        .where('status', isEqualTo: ChatRequestStatus.pending.name)
        .snapshots()
        .map((snapshot) {
          final requests = snapshot.docs
              .map((doc) => ChatRequest.fromMap({...doc.data(), 'id': doc.id}))
              .toList();
          requests.sort((a, b) {
            final aTime = a.createdAt;
            final bTime = b.createdAt;
            return bTime.compareTo(aTime);
          });
          return requests;
        });
  }

  static Future<void> respondToChatRequest({
    required String requestId,
    required ChatRequestStatus status,
    String? responseMessage,
  }) async {
    if (!FirebaseService.isInitialized) return;

    await _db
        .collection('chat_requests')
        .doc(requestId)
        .update({
      'status': status.name,
      'respondedAt': DateTime.now().toIso8601String(),
      'responseMessage': responseMessage,
    });

    // If approved, create private chat
    if (status == ChatRequestStatus.approved) {
      final requestDoc = await _db
          .collection('chat_requests')
          .doc(requestId)
          .get();

      if (requestDoc.exists) {
        final request = ChatRequest.fromMap({...requestDoc.data()!, 'id': requestId});
        await createPrivateChat(request.requesterId);
      }
    }
  }

  // User Search
  static Future<List<UserProfile>> searchUsers(String query) async {
    if (!FirebaseService.isInitialized) {
      return [];
    }

    final user = _auth.currentUser;
    if (user == null) {
      return [];
    }

    try {
      final snapshot = await _db
          .collection('users')
          .where('displayName', isGreaterThanOrEqualTo: query)
          .where('displayName', isLessThan: query + 'z')
          .limit(20)
          .get();

      return snapshot.docs
          .map((doc) => UserProfile.fromMap(doc.data()))
          .where((profile) => profile.uid != user.uid)
          .toList();
    } catch (_) {
      return [];
    }
  }

  static Future<List<UserProfile>> getMentors() async {
    if (!FirebaseService.isInitialized) {
      return [];
    }

    try {
      final snapshot = await _db
          .collection('users')
          .where('role', isEqualTo: UserRole.mentor.name)
          .limit(50)
          .get();

      return snapshot.docs
          .map((doc) => UserProfile.fromMap(doc.data()))
          .toList();
    } catch (_) {
      return [];
    }
  }

  // Stream version for real-time updates
  static Stream<List<UserProfile>> getMentorsStream() {
    if (!FirebaseService.isInitialized) {
      return Stream.value([]);
    }
    return _db
        .collection('users')
        .where('role', isEqualTo: UserRole.mentor.name)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UserProfile.fromMap(doc.data()))
            .toList());
  }

  // Get private chat requests for current user
  static Stream<List<PrivateChatRequest>> getPrivateChatRequests() {
    if (!FirebaseService.isInitialized) {
      return Stream.value([]);
    }
    final user = _auth.currentUser;
    if (user == null) return Stream.value([]);

    return _db
        .collection('private_chat_requests')
        .where('receiverId', isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PrivateChatRequest.fromMap(doc.data()))
            .toList());
  }

  // Accept private chat request
  static Future<ChatRoom?> acceptPrivateChatRequest(String requestId) async {
    if (!FirebaseService.isInitialized) return null;

    final user = _auth.currentUser;
    if (user == null) return null;

    final requestRef = _db.collection('private_chat_requests').doc(requestId);
    
    return await _db.runTransaction((transaction) async {
      final requestDoc = await transaction.get(requestRef);
      if (!requestDoc.exists) return null;

      final request = PrivateChatRequest.fromMap(requestDoc.data()!);
      if (request.receiverId != user.uid) return null;

      // Update request status
      transaction.update(requestRef, {'status': 'accepted'});

      // Create private chat room
      final chatRoom = ChatRoom(
        id: _uuid.v4(),
        type: ChatType.private,
        name: 'Private Chat',
        memberIds: [request.senderId, request.receiverId],
        createdAt: DateTime.now(),
      );

      transaction.set(_db.collection('chat_rooms').doc(chatRoom.id), chatRoom.toMap());
      return chatRoom;
    });
  }

  // Reject private chat request
  static Future<void> rejectPrivateChatRequest(String requestId) async {
    if (!FirebaseService.isInitialized) return;

    final user = _auth.currentUser;
    if (user == null) return;

    final requestRef = _db.collection('private_chat_requests').doc(requestId);
    await requestRef.update({'status': 'rejected'});
  }

  // Send private chat request
  static Future<void> sendPrivateChatRequest(String mentorId) async {
    if (!FirebaseService.isInitialized) return;

    final user = _auth.currentUser;
    if (user == null) return;

    final request = {
      'id': _uuid.v4(),
      'senderId': user.uid,
      'receiverId': mentorId,
      'timestamp': DateTime.now().toIso8601String(),
      'status': 'pending',
    };

    await _db.collection('private_chat_requests').doc(request['id']).set(request);
  }
}
