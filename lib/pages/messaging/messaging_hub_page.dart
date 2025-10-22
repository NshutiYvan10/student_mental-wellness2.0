import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/chat_models.dart';
import '../../models/user_profile.dart';
import '../../services/messaging_service.dart';
import '../../services/auth_service.dart';
import '../../widgets/gradient_background.dart';
import 'chat_room_page.dart';
import 'create_group_page.dart';
import 'mentor_list_page.dart';
import 'chat_requests_page.dart';
import 'user_search_page.dart';
import 'public_groups_page.dart';

class MessagingHubPage extends ConsumerStatefulWidget {
  const MessagingHubPage({super.key});

  @override
  ConsumerState<MessagingHubPage> createState() => _MessagingHubPageState();
}

class _MessagingHubPageState extends ConsumerState<MessagingHubPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  UserProfile? _currentUser;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadCurrentUser();
  }

  @override
  void dispose() {
    _tabController.dispose();
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
      body: GradientBackground(
        colors: [
          theme.colorScheme.primary.withValues(alpha: 0.1),
          theme.colorScheme.secondary.withValues(alpha: 0.05),
          theme.scaffoldBackgroundColor,
        ],
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
              left: 20,
              right: 20,
              bottom: 16,
              ),
              decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              boxShadow: [
              BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 3),
              ),
              ],
              ),
              child: Row(
              children: [
              Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                    theme.colorScheme.primary.withValues(alpha: 0.8),
                      theme.colorScheme.secondary.withValues(alpha: 0.6),
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
                        Icons.chat_bubble_outline_rounded,
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
                            'Messages',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: theme.colorScheme.onSurface,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            'Connect and get support',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_currentUser?.role == UserRole.mentor)
                      Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceVariant.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () => _showCreateGroupDialog(),
                          icon: Icon(
                            Icons.group_add_rounded,
                            color: theme.colorScheme.primary,
                            size: 20,
                          ),
                        ),
                      ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceVariant.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () => _showSearchDialog(),
                        icon: Icon(
                          Icons.search_rounded,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Tab Bar
              Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
              color: theme.colorScheme.surface.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha: 0.1),
                width: 0.5,
              ),
              boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
              ),
              child: TabBar(
              controller: _tabController,
                indicator: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.secondary,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  unselectedLabelColor: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  labelStyle: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  padding: const EdgeInsets.all(4),
                  tabs: const [
                    Tab(text: 'Chats'),
                    Tab(text: 'Mentors'),
                    Tab(text: 'Requests'),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const PublicGroupsPage(),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.explore_rounded),
                                label: const Text('Discover Groups'),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: _ChatsTab()),
                      ],
                    ),
                    _MentorsTab(),
                    _RequestsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateGroupDialog() {
    showDialog(
      context: context,
      builder: (context) => const CreateGroupDialog(),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => const UserSearchDialog(),
    );
  }
}

class _ChatsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatRoom>>(
      stream: MessagingService.getUserChatRooms(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final chatRooms = snapshot.data ?? [];

        if (chatRooms.isEmpty) {
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
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              Theme.of(context).colorScheme.secondary.withValues(alpha: 0.05),
              ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            borderRadius: BorderRadius.circular(60),
          ),
        child: Icon(
            Icons.chat_bubble_outline_rounded,
            size: 48,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
              ),
              ),
                const SizedBox(height: 24),
                  Text(
                    'No conversations yet',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Start a conversation with a mentor or join a group to begin connecting',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
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
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Find Mentors',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
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
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: chatRooms.length,
        itemBuilder: (context, index) {
        final chatRoom = chatRooms[index];
        return _ChatRoomTile(chatRoom: chatRoom);
        },
        );
      },
    );
  }
}

class _MentorsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserProfile>>(
      future: MessagingService.getMentors(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final mentors = snapshot.data ?? [];

        if (mentors.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.volunteer_activism_rounded,
                  size: 64,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                ),
                const SizedBox(height: 16),
                Text(
                  'No mentors available',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: mentors.length,
          itemBuilder: (context, index) {
            final mentor = mentors[index];
            return _MentorTile(mentor: mentor);
          },
        );
      },
    );
  }
}

class _RequestsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatRequest>>(
      stream: MessagingService.getChatRequests(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final requests = snapshot.data ?? [];

        if (requests.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_add_outlined,
                  size: 64,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                ),
                const SizedBox(height: 16),
                Text(
                  'No chat requests',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final request = requests[index];
            return _ChatRequestTile(request: request);
          },
        );
      },
    );
  }
}

class _ChatRoomTile extends StatelessWidget {
  final ChatRoom chatRoom;

  const _ChatRoomTile({required this.chatRoom});

  @override
  Widget build(BuildContext context) {
  final theme = Theme.of(context);

  return Container(
  margin: const EdgeInsets.only(bottom: 4, left: 16, right: 16),
  decoration: BoxDecoration(
  color: theme.colorScheme.surface,
  borderRadius: BorderRadius.circular(16),
  border: Border.all(
  color: theme.colorScheme.outline.withValues(alpha: 0.1),
  width: 0.5,
  ),
  boxShadow: [
  BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
        blurRadius: 6,
        offset: const Offset(0, 2),
    ),
  ],
  ),
  child: Material(
  color: Colors.transparent,
  child: InkWell(
  borderRadius: BorderRadius.circular(16),
  onTap: () {
  MessagingService.markRoomRead(chatRoom.id);
  Navigator.push(
  context,
  MaterialPageRoute(
  builder: (context) => ChatRoomPage(chatRoom: chatRoom),
  ),
  );
  },
  child: Padding(
  padding: const EdgeInsets.all(16),
  child: Row(
  children: [
    // Avatar with unread badge
  Stack(
    children: [
      Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          theme.colorScheme.primary.withValues(alpha: 0.8),
        theme.colorScheme.secondary.withValues(alpha: 0.6),
      ],
      begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
    borderRadius: BorderRadius.circular(28),
      boxShadow: [
        BoxShadow(
        color: theme.colorScheme.primary.withValues(alpha: 0.2),
      blurRadius: 8,
      offset: const Offset(0, 2),
  ),
  ],
  ),
  child: Icon(
    chatRoom.type == ChatType.group
          ? Icons.groups_rounded
            : Icons.person_rounded,
          color: Colors.white,
            size: 28,
            ),
            ),
              StreamBuilder<int>(
                stream: MessagingService.getUnreadCount(chatRoom.id),
              builder: (context, snapshot) {
                final unread = snapshot.data ?? 0;
              if (unread <= 0) return const SizedBox.shrink();
              return Positioned(
                  right: -2,
                    top: -2,
                    child: Container(
                    padding: const EdgeInsets.all(6),
                    constraints: const BoxConstraints(
                    minWidth: 24,
                    minHeight: 24,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                    theme.colorScheme.primary,
                      theme.colorScheme.secondary,
                      ],
                      ),
                        shape: BoxShape.circle,
                        boxShadow: [
                      BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.3),
                    blurRadius: 6,
                  offset: const Offset(0, 2),
                  ),
                  ],
                  ),
                      child: Center(
                      child: Text(
                        unread > 99 ? '99+' : unread.toString(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                      fontSize: 10,
                        fontWeight: FontWeight.w700,
                        ),
                        ),
                        ),
                        ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(width: 16),

                // Chat info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              chatRoom.name.isEmpty ? 'Private Chat' : chatRoom.name,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: theme.colorScheme.onSurface,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (chatRoom.lastMessageAt != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                _formatTime(chatRoom.lastMessageAt!),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          if (chatRoom.type == ChatType.group)
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.group_rounded,
                                size: 14,
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                              ),
                            ),
                          Expanded(
                            child: Text(
                              chatRoom.description ?? 'Tap to start chatting',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Arrow indicator
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

class _MentorTile extends StatelessWidget {
  final UserProfile mentor;

  const _MentorTile({required this.mentor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
          child: mentor.avatarUrl.isNotEmpty
              ? ClipOval(
                  child: Image.network(
                    mentor.avatarUrl,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.volunteer_activism_rounded,
                        color: theme.colorScheme.primary,
                      );
                    },
                  ),
                )
              : Icon(
                  Icons.volunteer_activism_rounded,
                  color: theme.colorScheme.primary,
                ),
        ),
        title: Text(
          mentor.displayName,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(mentor.school),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (mentor.isOnline)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => _sendChatRequest(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(80, 32),
              ),
              child: const Text('Chat'),
            ),
          ],
        ),
      ),
    );
  }

  void _sendChatRequest(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _ChatRequestDialog(mentor: mentor),
    );
  }
}

class _ChatRequestTile extends StatelessWidget {
  final ChatRequest request;

  const _ChatRequestTile({required this.request});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
          child: request.requesterAvatar != null && request.requesterAvatar!.isNotEmpty
              ? ClipOval(
                  child: Image.network(
                    request.requesterAvatar!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.person_rounded,
                        color: theme.colorScheme.primary,
                      );
                    },
                  ),
                )
              : Icon(
                  Icons.person_rounded,
                  color: theme.colorScheme.primary,
                ),
        ),
        title: Text(
          request.requesterName,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          request.message ?? 'Wants to start a conversation',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () => _respondToRequest(context, ChatRequestStatus.rejected),
              child: const Text('Decline'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => _respondToRequest(context, ChatRequestStatus.approved),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Accept'),
            ),
          ],
        ),
      ),
    );
  }

  void _respondToRequest(BuildContext context, ChatRequestStatus status) {
    MessagingService.respondToChatRequest(
      requestId: request.id,
      status: status,
    );
  }
}

class _ChatRequestDialog extends StatefulWidget {
  final UserProfile mentor;

  const _ChatRequestDialog({required this.mentor});

  @override
  State<_ChatRequestDialog> createState() => _ChatRequestDialogState();
}

class _ChatRequestDialogState extends State<_ChatRequestDialog> {
  final _messageController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AlertDialog(
      title: Text('Send Chat Request'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Send a chat request to ${widget.mentor.displayName}'),
          const SizedBox(height: 16),
          TextField(
            controller: _messageController,
            decoration: const InputDecoration(
              labelText: 'Message (optional)',
              hintText: 'Hi! I\'d like to chat with you...',
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _loading ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _loading ? null : _sendRequest,
          child: _loading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Send'),
        ),
      ],
    );
  }

  Future<void> _sendRequest() async {
    setState(() => _loading = true);
    
    try {
      await MessagingService.sendChatRequest(
        targetUserId: widget.mentor.uid,
        message: _messageController.text.trim().isEmpty 
            ? null 
            : _messageController.text.trim(),
      );
      
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Chat request sent successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send request: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }
}

class CreateGroupDialog extends StatelessWidget {
  const CreateGroupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const CreateGroupPage();
  }
}

class UserSearchDialog extends StatelessWidget {
  const UserSearchDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return UserSearchPage();
  }
}
