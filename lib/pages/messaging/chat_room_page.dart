import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/chat_models.dart';
import '../../models/user_profile.dart';
import '../../services/messaging_service.dart';
import '../../services/auth_service.dart';
import '../../widgets/gradient_background.dart';

class ChatRoomPage extends ConsumerStatefulWidget {
  final ChatRoom chatRoom;

  const ChatRoomPage({super.key, required this.chatRoom});

  @override
  ConsumerState<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends ConsumerState<ChatRoomPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  UserProfile? _currentUser;
  List<ChatMessage> _olderBuffer = [];
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadCurrentUser() async {
    final user = await AuthService.getCurrentUserProfile();
    if (mounted) {
      setState(() {
        _currentUser = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
      backgroundColor: theme.colorScheme.surface,
      elevation: 0,
      shadowColor: theme.colorScheme.shadow.withValues(alpha: 0.1),
      surfaceTintColor: theme.colorScheme.surface,
      title: Row(
      children: [
      Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
      gradient: LinearGradient(
      colors: [
      theme.colorScheme.primary.withValues(alpha: 0.8),
              theme.colorScheme.secondary.withValues(alpha: 0.8),
            ],
            begin: Alignment.topLeft,
          end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(22),
      boxShadow: [
      BoxShadow(
      color: theme.colorScheme.primary.withValues(alpha: 0.2),
      blurRadius: 8,
      offset: const Offset(0, 2),
      ),
      ],
      ),
      child: Icon(
      widget.chatRoom.type == ChatType.group
      ? Icons.groups_rounded
      : Icons.person_rounded,
      color: Colors.white,
      size: 22,
      ),
      ),
      const SizedBox(width: 16),
      Expanded(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(
      widget.chatRoom.name.isEmpty ? 'Private Chat' : widget.chatRoom.name,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
          color: theme.colorScheme.onSurface,
          ),
          ),
            if (widget.chatRoom.type == ChatType.group)
                Text(
                    '${widget.chatRoom.memberIds.length} members',
                    style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w500,
              ),
          )
      else
      StreamBuilder<List<String>>(
        stream: MessagingService.typingUsers(widget.chatRoom.id),
          builder: (context, snapshot) {
          final usersTyping = snapshot.data ?? [];
          if (usersTyping.isEmpty) {
                return Text(
                    'Tap to start chatting',
                    style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  fontWeight: FontWeight.w400,
                ),
            );
        }
        return Row(
          children: [
              Container(
                  width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                ),
            ),
            const SizedBox(width: 6),
            Text(
                usersTyping.length == 1 ? 'typing...' : '${usersTyping.length} typing...',
                  style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                        ),
                          ),
                          ],
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert_rounded,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            onPressed: () {
              if (widget.chatRoom.type == ChatType.group) {
                _showGroupMenu();
              }
            },
          ),
        ],
      ),
      body: Container(
      decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.primary.withValues(alpha: 0.03),
              theme.colorScheme.background,
            ],
          ),
        ),
        child: Column(
          children: [
            // Messages
            Expanded(
              child: StreamBuilder<List<ChatMessage>>(
                stream: MessagingService.getChatMessages(widget.chatRoom.id, limit: 50),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  final messages = [...(snapshot.data ?? []), ..._olderBuffer];

                  if (messages.isEmpty) {
                  return Center(
                  child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Container(
                    width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary.withValues(alpha: 0.1),
                        theme.colorScheme.secondary.withValues(alpha: 0.05),
                        ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      borderRadius: BorderRadius.circular(60),
                    ),
                  child: Icon(
                      widget.chatRoom.type == ChatType.group
                            ? Icons.groups_rounded
                              : Icons.chat_bubble_outline_rounded,
                            size: 48,
                              color: theme.colorScheme.primary.withValues(alpha: 0.6),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              widget.chatRoom.type == ChatType.group
                                  ? 'Welcome to the group!'
                                  : 'Start a conversation',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: theme.colorScheme.onSurface,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.chatRoom.type == ChatType.group
                                  ? 'Connect with fellow students in this supportive community.'
                                  : 'Send your first message to begin chatting.',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    theme.colorScheme.primary,
                                    theme.colorScheme.secondary,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.colorScheme.primary.withValues(alpha: 0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    widget.chatRoom.type == ChatType.group
                                        ? Icons.waving_hand_rounded
                                        : Icons.edit_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    widget.chatRoom.type == ChatType.group
                                        ? 'Say Hello'
                                        : 'Send Message',
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

          return ListView.builder(
          controller: _scrollController,
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          itemCount: messages.length,
          itemBuilder: (context, index) {
          final message = messages[index];
                  final isMe = message.senderId == _currentUser?.uid;

          // Group messages by sender and time
          final previousMessage = index > 0 ? messages[index - 1] : null;
          final showAvatar = !isMe && (previousMessage == null ||
            previousMessage.senderId != message.senderId ||
              message.createdAt.difference(previousMessage.createdAt).inMinutes > 5);
            final showTimestamp = previousMessage == null ||
                  message.createdAt.difference(previousMessage.createdAt).inMinutes > 15;

                      return Column(
                        children: [
                          if (showTimestamp)
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.surface.withValues(alpha: 0.8),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: theme.colorScheme.outline.withValues(alpha: 0.2),
                                  ),
                                ),
                                child: Text(
                                  _formatMessageDate(message.createdAt),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          GestureDetector(
                            onLongPressStart: (details) => _showReactionsBar(context, message, details.globalPosition),
                            child: TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 0.0, end: 1.0),
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOutCubic,
                              builder: (context, value, child) {
                                return Transform.translate(
                                  offset: Offset(isMe ? 20 * (1 - value) : -20 * (1 - value), 0),
                                  child: Opacity(
                                    opacity: value,
                                    child: child,
                                  ),
                                );
                              },
                              child: _MessageBubble(
                                message: message,
                                isMe: isMe,
                                showAvatar: showAvatar,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            
            // Message Input
            Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(
            top: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.1),
              width: 0.5,
              ),
              ),
              boxShadow: [
              BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
            ),
            ],
            ),
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
            Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
              width: 1,
            ),
            ),
              child: IconButton(
                icon: Icon(
                  Icons.add_rounded,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              size: 22,
            ),
              onPressed: () {
                // TODO: Add attachment functionality
            },
            ),
            ),
            const SizedBox(width: 12),
            Expanded(
            child: Container(
                constraints: const BoxConstraints(maxHeight: 120),
                  decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceVariant.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: theme.colorScheme.outline.withValues(alpha: 0.15),
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                        ),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                        maxLines: null,
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (v) => MessagingService.setTyping(chatRoomId: widget.chatRoom.id, isTyping: v.isNotEmpty),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.secondary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: _sendMessage,
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReactionsBar(BuildContext context, ChatMessage message, Offset position) async {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final overlaySize = overlay.size;
    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, overlaySize.width - position.dx, overlaySize.height - position.dy),
      items: const [
        PopupMenuItem(value: '👍', child: Text('👍')),
        PopupMenuItem(value: '❤️', child: Text('❤️')),
        PopupMenuItem(value: '👏', child: Text('👏')),
        PopupMenuItem(value: '😊', child: Text('😊')),
        PopupMenuItem(value: '🙏', child: Text('🙏')),
      ],
    );
    if (selected != null) {
      MessagingService.addMessageReaction(
        chatRoomId: widget.chatRoom.id,
        messageId: message.id,
        emoji: selected,
      );
    }
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    MessagingService.sendMessage(
      chatRoomId: widget.chatRoom.id,
      content: text,
    );

    _messageController.clear();
    
    // Scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _onScroll() async {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100 && !_isLoadingMore) {
      // Near the top in reverse ListView
      _isLoadingMore = true;
      try {
        final current = await MessagingService.getChatMessages(widget.chatRoom.id, limit: 1).first;
        final last = current.isNotEmpty ? current.last.createdAt : DateTime.now();
        final older = await MessagingService.fetchOlderMessages(
          chatRoomId: widget.chatRoom.id,
          before: last,
          limit: 50,
        );
        if (mounted && older.isNotEmpty) {
          setState(() {
            _olderBuffer.addAll(older);
          });
        }
      } finally {
        _isLoadingMore = false;
      }
    }
  }

  void _showGroupMenu() {
  showModalBottomSheet(
  context: context,
  backgroundColor: Colors.transparent,
    builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.info_outline_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('Group Info'),
              onTap: () {
                Navigator.pop(context);
                _showGroupInfo();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app_rounded,
                color: Colors.red,
              ),
              title: const Text('Leave Group'),
              onTap: () {
                Navigator.pop(context);
                _leaveGroup();
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatMessageDate(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (messageDate == today) {
      return 'Today';
    } else if (messageDate == yesterday) {
      return 'Yesterday';
    } else {
      final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                     'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return '${dateTime.day} ${months[dateTime.month - 1]}';
    }
  }

  void _showGroupInfo() {
    showDialog(
      context: context,
      builder: (context) => _GroupInfoDialog(chatRoom: widget.chatRoom),
    );
  }

  void _leaveGroup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Leave Group'),
        content: const Text('Are you sure you want to leave this group?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              MessagingService.leaveGroupChat(widget.chatRoom.id);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
final ChatMessage message;
final bool isMe;
  final bool showAvatar;

const _MessageBubble({
required this.message,
  required this.isMe,
    this.showAvatar = true,
  });

  @override
  Widget build(BuildContext context) {
  final theme = Theme.of(context);

  return Container(
  margin: EdgeInsets.only(bottom: 2, top: isMe ? 2 : 0),
  child: Row(
  mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  // Avatar for received messages
  if (!isMe && showAvatar) ...[
  Container(
  width: 36,
  height: 36,
  margin: const EdgeInsets.only(right: 12, top: 2),
  decoration: BoxDecoration(
  gradient: LinearGradient(
  colors: [
  theme.colorScheme.primary.withValues(alpha: 0.8),
  theme.colorScheme.secondary.withValues(alpha: 0.6),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  ),
  borderRadius: BorderRadius.circular(18),
  boxShadow: [
  BoxShadow(
  color: theme.colorScheme.primary.withValues(alpha: 0.2),
  blurRadius: 6,
    offset: const Offset(0, 2),
  ),
  ],
  ),
  child: message.senderAvatar != null && message.senderAvatar!.isNotEmpty
        ? ClipOval(
            child: Image.network(
                message.senderAvatar!,
                width: 36,
                height: 36,
              fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
            return Icon(
                Icons.person_rounded,
                size: 18,
                color: Colors.white.withValues(alpha: 0.9),
            );
      },
  ),
  )
  : Icon(
    Icons.person_rounded,
        size: 18,
        color: Colors.white.withValues(alpha: 0.9),
    ),
  ),
  ] else if (!isMe && !showAvatar) ...[
  const SizedBox(width: 48), // Space for alignment
  ],

  // Message bubble
  Flexible(
  child: Column(
  crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
  children: [
    // Sender name for group chats
  if (!isMe && showAvatar)
    Padding(
    padding: const EdgeInsets.only(bottom: 4),
  child: Text(
  message.senderName,
  style: theme.textTheme.bodySmall?.copyWith(
  color: theme.colorScheme.primary,
  fontWeight: FontWeight.w700,
  ),
  ),
  ),

  // Message content
  Container(
  constraints: BoxConstraints(
  maxWidth: MediaQuery.of(context).size.width * 0.75,
  ),
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  decoration: BoxDecoration(
  gradient: isMe
      ? LinearGradient(
        colors: [
        theme.colorScheme.primary,
        theme.colorScheme.secondary,
    ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
    )
    : LinearGradient(
        colors: [
        theme.colorScheme.surface,
        theme.colorScheme.surface.withValues(alpha: 0.9),
    ],
  ),
  borderRadius: BorderRadius.only(
  topLeft: const Radius.circular(18),
  topRight: const Radius.circular(18),
  bottomLeft: Radius.circular(isMe ? 18 : 6),
  bottomRight: Radius.circular(isMe ? 6 : 18),
  ),
  border: isMe
      ? null
        : Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.1),
            width: 0.5,
          ),
  boxShadow: [
    BoxShadow(
    color: isMe
        ? theme.colorScheme.primary.withValues(alpha: 0.3)
      : Colors.black.withValues(alpha: 0.08),
  blurRadius: 8,
  offset: const Offset(0, 3),
  ),
  ],
  ),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Text(
  message.content,
  style: theme.textTheme.bodyLarge?.copyWith(
  color: isMe
  ? Colors.white
  : theme.colorScheme.onSurface,
  height: 1.4,
  fontWeight: FontWeight.w400,
  ),
  ),
    const SizedBox(height: 6),
      Row(
          mainAxisSize: MainAxisSize.min,
            children: [
                Text(
                    _formatTime(message.createdAt),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isMe
                        ? Colors.white.withValues(alpha: 0.8)
                        : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
            if (message.isEdited) ...[
              const SizedBox(width: 6),
              Text(
                  'edited',
                    style: theme.textTheme.bodySmall?.copyWith(
                        color: isMe
                              ? Colors.white.withValues(alpha: 0.8)
                                : theme.colorScheme.onSurface.withValues(alpha: 0.5),
                              fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                // Reactions
                if (message.reactions.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    child: Wrap(
                      spacing: 6,
                      children: message.reactions.entries.map((entry) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: theme.colorScheme.outline.withValues(alpha: 0.2),
                              width: 0.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                entry.key,
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${entry.value.length}',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),

          // Avatar for sent messages (user's own avatar)
          if (isMe) ...[
            Container(
              width: 36,
              height: 36,
              margin: const EdgeInsets.only(left: 12, top: 2),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.secondary.withValues(alpha: 0.8),
                    theme.colorScheme.primary.withValues(alpha: 0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.secondary.withValues(alpha: 0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.person_rounded,
                size: 18,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${dateTime.day}/${dateTime.month} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else {
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }
}

class _GroupInfoDialog extends StatelessWidget {
  final ChatRoom chatRoom;

  const _GroupInfoDialog({required this.chatRoom});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AlertDialog(
      title: Text(chatRoom.name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (chatRoom.description != null) ...[
            Text(
              'Description',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(chatRoom.description!),
            const SizedBox(height: 16),
          ],
          Text(
            'Members (${chatRoom.memberIds.length})',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          // TODO: Load and display member profiles
          Text('Loading members...'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}

