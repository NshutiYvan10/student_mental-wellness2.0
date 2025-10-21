import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user_profile.dart';
import '../../services/messaging_service.dart';
import '../../services/auth_service.dart';

class MentorListPage extends ConsumerStatefulWidget {
  const MentorListPage({super.key});

  @override
  ConsumerState<MentorListPage> createState() => _MentorListPageState();
}

class _MentorListPageState extends ConsumerState<MentorListPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Mentors'),
      ),
      body: StreamBuilder<List<UserProfile>>(
        stream: MessagingService.getMentorsStream(),
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
              child: Text('No mentors available at the moment.'),
            );
          }

          final mentors = snapshot.data!;

          return ListView.builder(
            itemCount: mentors.length,
            itemBuilder: (context, index) {
              final mentor = mentors[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                    child: Text(
                      mentor.displayName.isNotEmpty 
                          ? mentor.displayName[0].toUpperCase()
                          : 'M',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(mentor.displayName),
                  subtitle: Text(mentor.school),
                  trailing: IconButton(
                    icon: const Icon(Icons.chat_rounded),
                    onPressed: () async {
                      try {
                        await MessagingService.sendPrivateChatRequest(mentor.uid);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Chat request sent to ${mentor.displayName}'),
                            ),
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to send request: $e'),
                            ),
                          );
                        }
                      }
                    },
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
