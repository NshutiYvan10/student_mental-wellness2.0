import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/chat_models.dart';
import '../../models/user_profile.dart';
import '../../services/messaging_service.dart';
import '../../services/auth_service.dart';

class ChatRequestsPage extends ConsumerStatefulWidget {
  const ChatRequestsPage({super.key});

  @override
  ConsumerState<ChatRequestsPage> createState() => _ChatRequestsPageState();
}

class _ChatRequestsPageState extends ConsumerState<ChatRequestsPage> {
  UserProfile? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
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

    if (_currentUser == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Only mentors can see chat requests
    if (_currentUser!.role != UserRole.mentor) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Chat Requests'),
        ),
        body: const Center(
          child: Text('Only mentors can view chat requests.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Requests'),
      ),
      body: StreamBuilder<List<PrivateChatRequest>>(
        stream: MessagingService.getPrivateChatRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No pending chat requests.'),
            );
          }

          final requests = snapshot.data!
              .where((request) => request.status == 'pending')
              .toList();

          if (requests.isEmpty) {
            return const Center(
              child: Text('No pending chat requests.'),
            );
          }

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text('Chat Request'),
                  subtitle: Text('From: ${request.senderId}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        onPressed: () async {
                          try {
                            final chatRoom = await MessagingService.acceptPrivateChatRequest(request.id);
                            if (mounted && chatRoom != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Chat request accepted'),
                                ),
                              );
                            }
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Failed to accept request: $e'),
                                ),
                              );
                            }
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () async {
                          try {
                            await MessagingService.rejectPrivateChatRequest(request.id);
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Chat request rejected'),
                                ),
                              );
                            }
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Failed to reject request: $e'),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


