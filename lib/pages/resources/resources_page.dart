import 'package:flutter/material.dart';

class ResourcesPage extends StatelessWidget {
  const ResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> items = const [
      {'title': 'Mindfulness Basics', 'type': 'Article', 'min': 5, 'category': 'Mindfulness'},
      {'title': 'Breathing Techniques', 'type': 'Video', 'min': 7, 'category': 'Mindfulness'},
      {'title': 'Coping with Anxiety', 'type': 'Guide', 'min': 10, 'category': 'Anxiety'},
      {'title': 'Sleep Hygiene 101', 'type': 'Article', 'min': 8, 'category': 'Sleep'},
      {'title': 'Guided Body Scan', 'type': 'Audio', 'min': 12, 'category': 'Mindfulness'},
      {'title': 'Gratitude Journaling', 'type': 'Guide', 'min': 6, 'category': 'Journaling'},
    ];

    final categories = <String>{ for (final r in items) r['category'] as String };

    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Resources',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Category filter chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: categories.map((c) => FilterChip(
                    label: Text(c),
                    onSelected: (_) {},
                    selected: false,
                  )).toList(),
                ),
                const SizedBox(height: 16),
                // Featured card
                _FeaturedResourceCard(theme: theme),
                const SizedBox(height: 24),
                // Grid of resources
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, i) {
                    final r = items[i];
                    return _ResourceCard(item: r);
                  },
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedResourceCard extends StatelessWidget {
  final ThemeData theme;
  const _FeaturedResourceCard({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          theme.colorScheme.primary,
          theme.colorScheme.secondary,
        ]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.spa_rounded, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Calm: 5-min Mindfulness',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'A guided micro-practice to reset your day',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(backgroundColor: Colors.white),
            child: Text('Start', style: TextStyle(color: theme.colorScheme.primary)),
          ),
        ],
      ),
    );
  }
}

class _ResourceCard extends StatelessWidget {
  final Map<String, Object> item;
  const _ResourceCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = item['title'] as String? ?? 'Untitled';
    final type = item['type'] as String? ?? 'Resource';
    final min = item['min'] as int? ?? 0;
    final category = item['category'] as String? ?? '';

    final icon = _iconForType(type);

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.colorScheme.outline.withOpacity(0.08)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Text(
              '$category • $type • $min min',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconForType(String type) {
    switch (type) {
      case 'Video':
        return Icons.play_circle_fill_rounded;
      case 'Audio':
        return Icons.headset_rounded;
      case 'Guide':
        return Icons.menu_book_rounded;
      case 'Article':
      default:
        return Icons.article_rounded;
    }
  }
}



