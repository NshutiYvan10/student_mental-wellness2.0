import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../services/chat_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: Column(
        children: [
          // Custom App Bar
          Container(
          padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 20,
          left: 20,
          right: 20,
          bottom: 20,
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
          width: 52,
          height: 52,
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
                color: theme.colorScheme.primary.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 3),
          ),
          ],
          ),
          child: Icon(
          Icons.groups_2_rounded,
          color: Colors.white,
          size: 26,
          ),
          ),
          const SizedBox(width: 16),
          Expanded(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text(
                  'Peer Support Chat',
                    style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                          color: theme.colorScheme.onSurface,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        'Connect with fellow students anonymously',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
                    icon: Icon(
                      Icons.more_vert_rounded,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      size: 20,
                    ),
                    onPressed: () {
                      // TODO: Add menu options
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Messages Area
          Expanded(
          child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          colors: [
              theme.colorScheme.primary.withValues(alpha: 0.02),
              theme.colorScheme.background,
          ],
          ),
          ),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: ChatService.messagesStream(),
          builder: (context, snapshot) {
          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
          return _buildEmptyState(theme);
          }
          return ListView.builder(
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          itemCount: docs.length,
            itemBuilder: (context, idx) {
                final data = docs[idx].data();
                  final sender = (data['sender'] as String?) ?? 'anon';
                    final text = (data['text'] as String?) ?? '';
                      final timestamp = (data['timestamp'] as Timestamp?)?.toDate();
                      final isMe = sender == 'anon';

                      // Group messages and add timestamps
                      final previousDoc = idx > 0 ? docs[idx - 1] : null;
                      final showTimestamp = previousDoc == null ||
                          timestamp != null && previousDoc['timestamp'] != null &&
                          timestamp.difference((previousDoc['timestamp'] as Timestamp).toDate()).inMinutes > 15;

                      return Column(
                        children: [
                          if (showTimestamp && timestamp != null)
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
                                  _formatMessageDate(timestamp),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOutCubic,
                            builder: (context, value, child) {
                              return Transform.translate(
                                offset: Offset(isMe ? 30 * (1 - value) : -30 * (1 - value), 0),
                                child: Opacity(
                                  opacity: value,
                                  child: child,
                                ),
                              );
                            },
                            child: _buildMessageBubble(theme, text, isMe, timestamp),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
          
          // Input Area
          _buildModernInputArea(theme),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
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
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chat_bubble_outline_rounded,
                size: 64,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Welcome to Peer Support',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Start a conversation with fellow students. Share your experiences, ask questions, or offer support to others.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                _controller.text = 'Hello everyone! 👋';
                _sendMessage();
              },
              icon: const Icon(Icons.waving_hand_rounded),
              label: const Text('Say Hello'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ThemeData theme, String text, bool isMe, DateTime? timestamp) {
  return Align(
  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
  child: ConstrainedBox(
  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
  child: Container(
  margin: const EdgeInsets.symmetric(vertical: 2),
  child: Row(
  mainAxisSize: MainAxisSize.min,
  crossAxisAlignment: CrossAxisAlignment.end,
  children: [
  if (!isMe) ...[
  Container(
  width: 32,
  height: 32,
  margin: const EdgeInsets.only(right: 8, bottom: 2),
  decoration: BoxDecoration(
  gradient: LinearGradient(
    colors: [
      theme.colorScheme.primary.withValues(alpha: 0.7),
      theme.colorScheme.secondary.withValues(alpha: 0.5),
      ],
      begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  ),
  borderRadius: BorderRadius.circular(16),
  boxShadow: [
      BoxShadow(
      color: theme.colorScheme.primary.withValues(alpha: 0.2),
    blurRadius: 6,
    offset: const Offset(0, 2),
  ),
  ],
  ),
    child: Icon(
      Icons.person_rounded,
    size: 16,
    color: Colors.white.withValues(alpha: 0.9),
  ),
  ),
  ],
  Flexible(
    child: Container(
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
                              theme.colorScheme.surface.withValues(alpha: 0.95),
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
                            color: theme.colorScheme.outline.withValues(alpha: 0.15),
                            width: 0.5,
                          ),
                    boxShadow: [
                      BoxShadow(
                        color: isMe
                            ? theme.colorScheme.primary.withValues(alpha: 0.3)
                            : Colors.black.withValues(alpha: 0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: isMe ? Colors.white : theme.colorScheme.onSurface,
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (timestamp != null)
                            Text(
                              _formatTime(timestamp),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: isMe
                                    ? Colors.white.withValues(alpha: 0.8)
                                    : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (isMe) ...[
                Container(
                  width: 32,
                  height: 32,
                  margin: const EdgeInsets.only(left: 8, bottom: 2),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.secondary.withValues(alpha: 0.7),
                        theme.colorScheme.primary.withValues(alpha: 0.5),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
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
                    size: 16,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernInputArea(ThemeData theme) {
  return Container(
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
      blurRadius: 12,
    offset: const Offset(0, -3),
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
      controller: _controller,
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
              icon: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 22,
              ),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    await ChatService.sendMessage(text);
    _controller.clear();
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

  String _formatTime(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) {
      final hour = date.hour.toString().padLeft(2, '0');
      final minute = date.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    } else {
      return '${date.day}/${date.month}';
    }
  }
}


