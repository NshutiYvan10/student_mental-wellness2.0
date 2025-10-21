import 'package:flutter/material.dart';

class AvatarSelector extends StatelessWidget {
  final String? selectedAvatar;
  final Function(String) onAvatarSelected;

  const AvatarSelector({
    super.key,
    this.selectedAvatar,
    required this.onAvatarSelected,
  });

  // Professional preset avatar IDs (icon-based)
  static const List<String> availableAvatars = [
    'icon:person',
    'icon:self_improvement',
    'icon:spa',
    'icon:emoji_nature',
    'icon:psychology',
    'icon:palette',
    'icon:favorite',
    'icon:auto_awesome',
    'icon:travel_explore',
    'icon:school',
    'icon:bolt',
    'icon:health_and_safety',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose Your Avatar',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: availableAvatars.length,
            itemBuilder: (context, index) {
              final avatar = availableAvatars[index];
              final isSelected = selectedAvatar == avatar;
              
              return GestureDetector(
                onTap: () => onAvatarSelected(avatar),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? theme.colorScheme.primary.withValues(alpha: 0.12)
                        : theme.colorScheme.surfaceVariant.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected 
                          ? theme.colorScheme.primary
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      _iconForId(avatar),
                      size: isSelected ? 26 : 22,
                      color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  IconData _iconForId(String id) {
    switch (id) {
      case 'icon:self_improvement':
        return Icons.self_improvement_rounded;
      case 'icon:spa':
        return Icons.spa_rounded;
      case 'icon:emoji_nature':
        return Icons.emoji_nature_rounded;
      case 'icon:psychology':
        return Icons.psychology_rounded;
      case 'icon:palette':
        return Icons.palette_rounded;
      case 'icon:favorite':
        return Icons.favorite_rounded;
      case 'icon:auto_awesome':
        return Icons.auto_awesome_rounded;
      case 'icon:travel_explore':
        return Icons.travel_explore_rounded;
      case 'icon:school':
        return Icons.school_rounded;
      case 'icon:bolt':
        return Icons.bolt_rounded;
      case 'icon:health_and_safety':
        return Icons.health_and_safety_rounded;
      case 'icon:person':
      default:
        return Icons.person_rounded;
    }
  }
}


