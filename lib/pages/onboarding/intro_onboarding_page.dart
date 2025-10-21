import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroOnboardingPage extends StatefulWidget {
  const IntroOnboardingPage({super.key});

  @override
  State<IntroOnboardingPage> createState() => _IntroOnboardingPageState();
}

class _IntroOnboardingPageState extends State<IntroOnboardingPage>
    with TickerProviderStateMixin {
  late final PageController _pageController;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    final slides = [
      _IntroSlide(
        lottieAsset: 'assets/lottie/student.json',
        title: 'Welcome to Your Wellness Journey',
        subtitle:
            'Discover a safe space designed for students to understand emotions, build healthy habits, and thrive academically and personally.',
      ),
      _IntroSlide(
        icon: Icons.mood_rounded,
        title: 'Track Your Mood Daily',
        subtitle:
            'Log your feelings with intuitive mood tracking. Gain insights into patterns and learn what truly impacts your well-being.',
      ),
      _IntroSlide(
        icon: Icons.edit_rounded,
        title: 'Journal Your Thoughts',
        subtitle:
            'Express yourself freely through guided journaling. Our AI analyzes your entries to provide personalized reflections and growth insights.',
      ),
      _IntroSlide(
        icon: Icons.chat_bubble_rounded,
        title: 'Connect & Support',
        subtitle:
            'Join a supportive community of peers and mentors. Share experiences, get advice, and build meaningful connections in a safe environment.',
      ),
    ];
    if (_current < slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final slides = [
      _IntroSlide(
        lottieAsset: 'assets/lottie/student.json',
        title: 'Welcome to Your Wellness Journey',
        subtitle:
            'Discover a safe space designed for students to understand emotions, build healthy habits, and thrive academically and personally.',
      ),
      _IntroSlide(
        icon: Icons.mood_rounded,
        title: 'Track Your Mood Daily',
        subtitle:
            'Log your feelings with intuitive mood tracking. Gain insights into patterns and learn what truly impacts your well-being.',
      ),
      _IntroSlide(
        icon: Icons.edit_rounded,
        title: 'Journal Your Thoughts',
        subtitle:
            'Express yourself freely through guided journaling. Our AI analyzes your entries to provide personalized reflections and growth insights.',
      ),
      _IntroSlide(
        icon: Icons.chat_bubble_rounded,
        title: 'Connect & Support',
        subtitle:
            'Join a supportive community of peers and mentors. Share experiences, get advice, and build meaningful connections in a safe environment.',
      ),
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _current = i.clamp(0, slides.length - 1)),
                children: slides,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Row(
                children: [
                  _Dots(count: slides.length, current: _current),
                  const Spacer(),
                  FilledButton(
                    onPressed: _next,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(_current < slides.length - 1 ? 'Next' : 'Get started',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IntroSlide extends StatelessWidget {
  final String? lottieAsset;
  final IconData? icon;
  final String title;
  final String subtitle;

  const _IntroSlide({
    this.lottieAsset,
    this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (lottieAsset != null)
            Lottie.asset(lottieAsset!, height: 240, fit: BoxFit.contain)
          else
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  theme.colorScheme.primary.withOpacity(0.8),
                  theme.colorScheme.secondary.withOpacity(0.8),
                ]),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 88),
            ),
          const SizedBox(height: 40),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineLarge?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  final int count;
  final int current;

  const _Dots({required this.count, required this.current});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (count <= 0) return const SizedBox.shrink();
    return Row(
      children: List.generate(count, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.only(right: 8),
          height: 8,
          width: active ? 24 : 8,
          decoration: BoxDecoration(
            color: active
                ? theme.colorScheme.primary
                : theme.colorScheme.primary.withOpacity(0.25),
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }),
    );
  }
}


