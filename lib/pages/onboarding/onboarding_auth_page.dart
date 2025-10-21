// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import '../../models/user_profile.dart';
// import '../../services/auth_service.dart';
// import '../../services/firebase_service.dart';
// import '../../widgets/avatar_selector.dart';
//
// // Main widget to handle the entire onboarding and authentication flow
// class OnboardingAuthPage extends StatefulWidget {
//   const OnboardingAuthPage({super.key});
//
//   @override
//   State<OnboardingAuthPage> createState() => _OnboardingAuthPageState();
// }
//
// class _OnboardingAuthPageState extends State<OnboardingAuthPage> {
//   final PageController _pageController = PageController();
//   UserRole? _selectedRole;
//
//   void _onRoleSelected(UserRole role) {
//     setState(() {
//       _selectedRole = role;
//     });
//     _pageController.animateToPage(
//       2,
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void _navigateToLogin() {
//     _pageController.animateToPage(
//       3,
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void _navigateToSignUp() {
//     _pageController.animateToPage(
//       2,
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: [
//           const OnboardingScreen(),
//           RoleSelectionScreen(onRoleSelected: _onRoleSelected),
//           SignUpScreen(
//               role: _selectedRole ?? UserRole.student,
//               onLoginTapped: _navigateToLogin),
//           LoginScreen(
//               role: _selectedRole ?? UserRole.student,
//               onSignUpTapped: _navigateToSignUp),
//         ],
//       ),
//     );
//   }
// }
//
// // 1. Onboarding Carousel Screen
// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});
//
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//
//   final List<Map<String, String>> _onboardingData = [
//     {
//       "animation": "assets/lottie/breathing.json",
//       "headline": "Find Your Calm",
//       "description":
//       "Explore guided meditations and breathing exercises to reduce stress and find your inner peace.",
//     },
//     {
//       "animation": "assets/lottie/journaling.json",
//       "headline": "Reflect & Grow",
//       "description":
//       "Use the AI-powered journal to understand your thoughts and track your emotional well-being over time.",
//     },
//     {
//       "animation": "assets/lottie/community.json",
//       "headline": "Connect & Share",
//       "description":
//       "Join a supportive community, connect with mentors, and share your journey with peers who understand.",
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               flex: 3,
//               child: PageView.builder(
//                 controller: _pageController,
//                 itemCount: _onboardingData.length,
//                 onPageChanged: (index) {
//                   setState(() {
//                     _currentPage = index;
//                   });
//                 },
//                 itemBuilder: (context, index) {
//                   return OnboardingSlide(
//                     key: ValueKey(index),
//                     data: _onboardingData[index],
//                   );
//                 },
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: List.generate(
//                         _onboardingData.length,
//                             (index) => buildDot(index, context),
//                       ),
//                     ),
//                     const Spacer(),
//                     _GetStartedButton(
//                       onPressed: () {
//                         // Find the parent PageView and navigate
//                         final parentPageState = context
//                             .findAncestorStateOfType<_OnboardingAuthPageState>();
//                         parentPageState?._pageController.animateToPage(1,
//                             duration: const Duration(milliseconds: 400),
//                             curve: Curves.easeInOut);
//                       },
//                     ),
//                     const SizedBox(height: 40),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildDot(int index, BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeOut,
//       margin: const EdgeInsets.only(right: 8),
//       height: 8,
//       width: _currentPage == index ? 24 : 8,
//       decoration: BoxDecoration(
//         color: _currentPage == index
//             ? Theme.of(context).colorScheme.primary
//             : Colors.grey.shade300,
//         borderRadius: BorderRadius.circular(4),
//       ),
//     );
//   }
// }
//
// class OnboardingSlide extends StatefulWidget {
//   final Map<String, String> data;
//
//   const OnboardingSlide({super.key, required this.data});
//
//   @override
//   State<OnboardingSlide> createState() => _OnboardingSlideState();
// }
//
// class _OnboardingSlideState extends State<OnboardingSlide>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//     _fadeAnimation =
//         Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//           parent: _controller,
//           curve: Curves.easeOut,
//         ));
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.2),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeOutCubic,
//     ));
//
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Expanded(
//           child: FadeTransition(
//             opacity: _fadeAnimation,
//             child: Lottie.asset(
//               widget.data['animation']!,
//               width: 300,
//               height: 300,
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//         const SizedBox(height: 40),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 32.0),
//           child: SlideTransition(
//             position: _slideAnimation,
//             child: FadeTransition(
//               opacity: _fadeAnimation,
//               child: Column(
//                 children: [
//                   Text(
//                     widget.data['headline']!,
//                     style: theme.textTheme.headlineMedium?.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color: theme.colorScheme.onSurface,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     widget.data['description']!,
//                     style: theme.textTheme.titleMedium?.copyWith(
//                       color: theme.colorScheme.onSurface.withOpacity(0.6),
//                       height: 1.5,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _GetStartedButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   const _GetStartedButton({required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             gradient: LinearGradient(
//               colors: [
//                 theme.colorScheme.primary,
//                 theme.colorScheme.secondary,
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: theme.colorScheme.primary.withOpacity(0.3),
//                 blurRadius: 10,
//                 offset: const Offset(0, 5),
//               )
//             ]),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'Get Started',
//               style: theme.textTheme.titleMedium
//                   ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(width: 8),
//             const Icon(Icons.arrow_forward_rounded, color: Colors.white),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // 2. Role Selection Screen
// class RoleSelectionScreen extends StatefulWidget {
//   final Function(UserRole) onRoleSelected;
//
//   const RoleSelectionScreen({super.key, required this.onRoleSelected});
//
//   @override
//   State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
// }
//
// class _RoleSelectionScreenState extends State<RoleSelectionScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//     _fadeAnimation =
//         Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//           parent: _controller,
//           curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
//         ));
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.3),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeOutCubic,
//     ));
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Spacer(),
//               FadeTransition(
//                 opacity: _fadeAnimation,
//                 child: SlideTransition(
//                   position: _slideAnimation,
//                   child: Column(
//                     children: [
//                       Text(
//                         'Choose Your Role',
//                         style: theme.textTheme.displaySmall?.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: theme.colorScheme.onSurface,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         'How will you be using the app?',
//                         style: theme.textTheme.titleMedium?.copyWith(
//                           color: theme.colorScheme.onSurface.withOpacity(0.6),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 48),
//               SlideTransition(
//                 position: _slideAnimation,
//                 child: FadeTransition(
//                   opacity: _fadeAnimation,
//                   child: RoleCard(
//                     role: UserRole.student,
//                     onTap: () => widget.onRoleSelected(UserRole.student),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               SlideTransition(
//                 position: _slideAnimation,
//                 child: FadeTransition(
//                   opacity: _fadeAnimation,
//                   child: RoleCard(
//                     role: UserRole.mentor,
//                     onTap: () => widget.onRoleSelected(UserRole.mentor),
//                   ),
//                 ),
//               ),
//               const Spacer(flex: 2),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class RoleCard extends StatefulWidget {
//   final UserRole role;
//   final VoidCallback onTap;
//
//   const RoleCard({super.key, required this.role, required this.onTap});
//
//   @override
//   State<RoleCard> createState() => _RoleCardState();
// }
//
// class _RoleCardState extends State<RoleCard> {
//   bool _isHovered = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return MouseRegion(
//       onEnter: (_) => setState(() => _isHovered = true),
//       onExit: (_) => setState(() => _isHovered = false),
//       child: GestureDetector(
//         onTap: widget.onTap,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             color: _isHovered
//                 ? theme.colorScheme.primary.withOpacity(0.05)
//                 : theme.colorScheme.surface,
//             borderRadius: BorderRadius.circular(24),
//             border: Border.all(
//               color: _isHovered
//                   ? theme.colorScheme.primary
//                   : theme.colorScheme.outline.withOpacity(0.2),
//               width: 1.5,
//             ),
//             boxShadow: _isHovered
//                 ? [
//               BoxShadow(
//                 color: theme.colorScheme.primary.withOpacity(0.1),
//                 blurRadius: 16,
//                 offset: const Offset(0, 8),
//               )
//             ]
//                 : [],
//           ),
//           child: Row(
//             children: [
//               Icon(widget.role.icon,
//                   size: 32,
//                   color: _isHovered
//                       ? theme.colorScheme.primary
//                       : theme.colorScheme.onSurface.withOpacity(0.7)),
//               const SizedBox(width: 20),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.role.displayName,
//                       style: theme.textTheme.titleLarge?.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: theme.colorScheme.onSurface,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       widget.role.description,
//                       style: theme.textTheme.bodyMedium?.copyWith(
//                         color: theme.colorScheme.onSurface.withOpacity(0.6),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Icon(Icons.arrow_forward_ios_rounded,
//                   size: 18,
//                   color: theme.colorScheme.onSurface.withOpacity(0.5)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // 3. Sign Up Screen
// class SignUpScreen extends StatefulWidget {
//   final UserRole role;
//   final VoidCallback onLoginTapped;
//   const SignUpScreen(
//       {super.key, required this.role, required this.onLoginTapped});
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailCtrl = TextEditingController();
//   final _passwordCtrl = TextEditingController();
//   final _displayNameCtrl = TextEditingController();
//   final _schoolCtrl = TextEditingController();
//   String? _selectedAvatar;
//   bool _loading = false;
//
//   @override
//   void dispose() {
//     _emailCtrl.dispose();
//     _passwordCtrl.dispose();
//     _displayNameCtrl.dispose();
//     _schoolCtrl.dispose();
//     super.dispose();
//   }
//
//   Future<void> _signup() async {
//     if (!_formKey.currentState!.validate()) return;
//     setState(() => _loading = true);
//
//     try {
//       if (!FirebaseService.isInitialized) {
//         throw StateError(
//             'Firebase is not configured. Run FlutterFire and enable Email/Password auth.');
//       }
//       await AuthService.signUpWithEmail(
//         _emailCtrl.text.trim(),
//         _passwordCtrl.text.trim(),
//         displayName: _displayNameCtrl.text.trim(),
//         school: _schoolCtrl.text.trim(),
//         role: widget.role,
//       );
//
//       if (!mounted) return;
//       Navigator.pushReplacementNamed(context, '/dashboard');
//     } catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Signup failed: ${_friendlyError(e)}'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       if (mounted) {
//         setState(() => _loading = false);
//       }
//     }
//   }
//
//   String _friendlyError(Object e) {
//     // ... (error handling from original code)
//     return e.toString();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const AuthHeader(),
//             Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     TextFormField(
//                       controller: _displayNameCtrl,
//                       decoration: const InputDecoration(
//                           labelText: 'Display Name',
//                           prefixIcon: Icon(Icons.person_outline_rounded)),
//                       validator: (v) => v != null && v.isNotEmpty
//                           ? null
//                           : 'Display name is required',
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _emailCtrl,
//                       decoration: const InputDecoration(
//                           labelText: 'Email',
//                           prefixIcon: Icon(Icons.email_outlined)),
//                       validator: (v) =>
//                       v != null && v.contains('@') ? null : 'Invalid email',
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _passwordCtrl,
//                       decoration: const InputDecoration(
//                           labelText: 'Password',
//                           prefixIcon: Icon(Icons.lock_outline_rounded)),
//                       obscureText: true,
//                       validator: (v) => (v != null && v.length >= 6)
//                           ? null
//                           : 'Password must be at least 6 characters',
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _schoolCtrl,
//                       decoration: const InputDecoration(
//                           labelText: 'School/Institution',
//                           prefixIcon: Icon(Icons.school_outlined)),
//                       validator: (v) =>
//                       v != null && v.isNotEmpty ? null : 'School required',
//                     ),
//                     const SizedBox(height: 24),
//                     AvatarSelector(
//                       selectedAvatar: _selectedAvatar,
//                       onAvatarSelected: (avatar) {
//                         setState(() {
//                           _selectedAvatar = avatar;
//                         });
//                       },
//                     ),
//                     const SizedBox(height: 24),
//                     _AuthButton(
//                       label: 'Create Account',
//                       onPressed: _signup,
//                       isLoading: _loading,
//                     ),
//                     const SizedBox(height: 24),
//                     const _OrDivider(),
//                     const SizedBox(height: 24),
//                     const _SocialLoginButtons(),
//                     const SizedBox(height: 32),
//                     _BottomText(
//                       text: 'Already have an account?',
//                       buttonText: 'Login',
//                       onPressed: widget.onLoginTapped,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // 4. Login Screen
// class LoginScreen extends StatefulWidget {
//   final UserRole role;
//   final VoidCallback onSignUpTapped;
//
//   const LoginScreen(
//       {super.key, required this.role, required this.onSignUpTapped});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailCtrl = TextEditingController();
//   final _passwordCtrl = TextEditingController();
//   bool _loading = false;
//
//   Future<void> _login() async {
//     if (!_formKey.currentState!.validate()) return;
//     setState(() => _loading = true);
//
//     try {
//       if (!FirebaseService.isInitialized) {
//         throw StateError(
//             'Firebase is not configured. Run FlutterFire and enable Email/Password auth.');
//       }
//       await AuthService.signInWithEmail(
//           _emailCtrl.text.trim(), _passwordCtrl.text.trim());
//
//       if (!mounted) return;
//       Navigator.pushReplacementNamed(context, '/dashboard');
//     } catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Login failed: ${_friendlyError(e)}'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       if (mounted) {
//         setState(() => _loading = false);
//       }
//     }
//   }
//
//   String _friendlyError(Object e) {
//     // ... (error handling from original code)
//     return e.toString();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const AuthHeader(),
//             Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     TextFormField(
//                       controller: _emailCtrl,
//                       decoration: const InputDecoration(
//                           labelText: 'Email',
//                           prefixIcon: Icon(Icons.email_outlined)),
//                       validator: (v) =>
//                       v != null && v.contains('@') ? null : 'Invalid email',
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _passwordCtrl,
//                       decoration: const InputDecoration(
//                           labelText: 'Password',
//                           prefixIcon: Icon(Icons.lock_outline_rounded)),
//                       obscureText: true,
//                       validator: (v) => (v != null && v.isNotEmpty)
//                           ? null
//                           : 'Password is required',
//                     ),
//                     const SizedBox(height: 24),
//                     _AuthButton(
//                       label: 'Login',
//                       onPressed: _login,
//                       isLoading: _loading,
//                     ),
//                     const SizedBox(height: 24),
//                     const _OrDivider(),
//                     const SizedBox(height: 24),
//                     const _SocialLoginButtons(),
//                     const SizedBox(height: 32),
//                     _BottomText(
//                       text: "Don't have an account?",
//                       buttonText: 'Sign Up',
//                       onPressed: widget.onSignUpTapped,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // --- Shared Auth Widgets ---
//
// class AuthHeader extends StatelessWidget {
//   const AuthHeader({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return ClipPath(
//       clipper: WaveClipper(),
//       child: Container(
//         height: 220,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               theme.colorScheme.primary,
//               theme.colorScheme.secondary,
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child:
//           Lottie.asset('assets/lottie/lotus.json', width: 150, height: 150),
//         ),
//       ),
//     );
//   }
// }
//
// class WaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.lineTo(0, size.height - 50);
//     var firstControlPoint = Offset(size.width / 4, size.height);
//     var firstEndPoint = Offset(size.width / 2, size.height - 50);
//     path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
//         firstEndPoint.dx, firstEndPoint.dy);
//
//     var secondControlPoint = Offset(size.width * 3 / 4, size.height - 100);
//     var secondEndPoint = Offset(size.width, size.height - 60);
//     path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
//         secondEndPoint.dx, secondEndPoint.dy);
//
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
//
// class _AuthButton extends StatelessWidget {
//   final String label;
//   final VoidCallback onPressed;
//   final bool isLoading;
//
//   const _AuthButton(
//       {required this.label, required this.onPressed, this.isLoading = false});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return GestureDetector(
//       onTap: isLoading ? null : onPressed,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         padding: const EdgeInsets.symmetric(vertical: 16),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           gradient: LinearGradient(
//             colors: [
//               theme.colorScheme.primary,
//               theme.colorScheme.secondary,
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: theme.colorScheme.primary.withOpacity(0.3),
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             )
//           ],
//         ),
//         child: Center(
//           child: isLoading
//               ? const SizedBox(
//               width: 24,
//               height: 24,
//               child:
//               CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
//               : Text(
//             label,
//             style: theme.textTheme.titleMedium?.copyWith(
//                 color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _OrDivider extends StatelessWidget {
//   const _OrDivider();
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Row(
//       children: [
//         Expanded(
//             child: Divider(color: theme.colorScheme.outline.withOpacity(0.3))),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Text(
//             'OR',
//             style: theme.textTheme.bodySmall
//                 ?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.5)),
//           ),
//         ),
//         Expanded(
//             child: Divider(color: theme.colorScheme.outline.withOpacity(0.3))),
//       ],
//     );
//   }
// }
//
// class _SocialLoginButtons extends StatelessWidget {
//   const _SocialLoginButtons();
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         _SocialButton(
//             asset: 'assets/images/google_logo.png', onPressed: () {}),
//         const SizedBox(width: 24),
//         _SocialButton(asset: 'assets/images/apple_logo.png', onPressed: () {}),
//       ],
//     );
//   }
// }
//
// class _SocialButton extends StatelessWidget {
//   final String asset;
//   final VoidCallback onPressed;
//   const _SocialButton({required this.asset, required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: theme.colorScheme.surface,
//           border:
//           Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             )
//           ],
//         ),
//         child: Image.asset(asset, width: 32, height: 32),
//       ),
//     );
//   }
// }
//
// class _BottomText extends StatelessWidget {
//   final String text;
//   final String buttonText;
//   final VoidCallback onPressed;
//
//   const _BottomText(
//       {required this.text, required this.buttonText, required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(text,
//             style: theme.textTheme.bodyMedium
//                 ?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.6))),
//         TextButton(
//           onPressed: onPressed,
//           child: Text(
//             buttonText,
//             style: theme.textTheme.bodyMedium?.copyWith(
//                 color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }
// }
























// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'dart:ui';
//
// import '../../models/user_profile.dart';
// import '../../services/auth_service.dart';
// import '../../services/firebase_service.dart';
//
// // Main PageView orchestrator for the entire flow
// class OnboardingAuthPage extends StatefulWidget {
//   const OnboardingAuthPage({super.key});
//
//   @override
//   State<OnboardingAuthPage> createState() => _OnboardingAuthPageState();
// }
//
// class _OnboardingAuthPageState extends State<OnboardingAuthPage> {
//   final PageController _pageController = PageController();
//   UserRole _selectedRole = UserRole.student; // Default role
//
//   void _navigateToPage(int page) {
//     _pageController.animateToPage(
//       page,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOutCubic,
//     );
//   }
//
//   void _onRoleSelected(UserRole role) {
//     setState(() {
//       _selectedRole = role;
//     });
//     _navigateToPage(2); // Navigate to Sign Up
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: PageView(
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: [
//           OnboardingScreen(onGetStarted: () => _navigateToPage(1)),
//           RoleSelectionScreen(onRoleSelected: _onRoleSelected),
//           SignUpScreen(
//               role: _selectedRole, onLoginTapped: () => _navigateToPage(3)),
//           LoginScreen(
//               role: _selectedRole, onSignUpTapped: () => _navigateToPage(2)),
//         ],
//       ),
//     );
//   }
// }
//
// // 1. Jaw-Dropping Onboarding Screen
// class OnboardingScreen extends StatefulWidget {
//   final VoidCallback onGetStarted;
//   const OnboardingScreen({super.key, required this.onGetStarted});
//
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//
//   static const List<Map<String, String>> _onboardingData = [
//     {
//       "animation": "assets/lottie/mindful_shape.json",
//       "headline": "Find Your Center",
//       "description":
//       "Life as a student is demanding. Discover guided breathing and mindfulness exercises to find your calm amidst the chaos.",
//     },
//     {
//       "animation": "assets/lottie/growing_plant.json",
//       "headline": "Understand Your Journey",
//       "description":
//       "Your thoughts and feelings are valid. Our smart journal helps you track your mood patterns and reflect on your personal growth.",
//     },
//     {
//       "animation": "assets/lottie/supportive_hands.json",
//       "headline": "You Are Not Alone",
//       "description":
//       "Connect with a supportive community of peers and mentors. Share experiences and find strength in shared understanding.",
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               flex: 6,
//               child: PageView.builder(
//                 controller: _pageController,
//                 itemCount: _onboardingData.length,
//                 onPageChanged: (index) => setState(() => _currentPage = index),
//                 itemBuilder: (_, index) => OnboardingSlide(
//                   key: ValueKey(index),
//                   data: _onboardingData[index],
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 4,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                 child: Column(
//                   children: [
//                     const Spacer(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: List.generate(
//                         _onboardingData.length,
//                             (index) => buildDotIndicator(index),
//                       ),
//                     ),
//                     const Spacer(flex: 2),
//                     OnboardingActionButton(
//                       label:
//                       _currentPage == _onboardingData.length - 1 ? 'Get Started' : 'Next',
//                       onPressed: () {
//                         if (_currentPage == _onboardingData.length - 1) {
//                           widget.onGetStarted();
//                         } else {
//                           _pageController.nextPage(
//                             duration: const Duration(milliseconds: 400),
//                             curve: Curves.easeInOut,
//                           );
//                         }
//                       },
//                     ),
//                     const Spacer(),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildDotIndicator(int index) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       margin: const EdgeInsets.symmetric(horizontal: 4),
//       height: 8,
//       width: _currentPage == index ? 24 : 8,
//       decoration: BoxDecoration(
//         color: _currentPage == index
//             ? Theme.of(context).colorScheme.primary
//             : Theme.of(context).colorScheme.primary.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(4),
//       ),
//     );
//   }
// }
//
// class OnboardingSlide extends StatelessWidget {
//   final Map<String, String> data;
//   const OnboardingSlide({super.key, required this.data});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Padding(
//       padding: const EdgeInsets.all(24.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: Lottie.asset(
//               data['animation']!,
//               fit: BoxFit.contain,
//             ),
//           ),
//           const SizedBox(height: 48),
//           Text(
//             data['headline']!,
//             style: theme.textTheme.displaySmall,
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 16),
//           Text(
//             data['description']!,
//             style: theme.textTheme.bodyLarge,
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class OnboardingActionButton extends StatelessWidget {
//   final String label;
//   final VoidCallback onPressed;
//
//   const OnboardingActionButton({super.key, required this.label, required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: theme.elevatedButtonTheme.style?.copyWith(
//         padding: MaterialStateProperty.all(
//           const EdgeInsets.symmetric(vertical: 18, horizontal: 80),
//         ),
//       ),
//       child: Text(label),
//     );
//   }
// }
//
//
// // 2. Premium Role Selection Screen
// class RoleSelectionScreen extends StatelessWidget {
//   final Function(UserRole) onRoleSelected;
//
//   const RoleSelectionScreen({super.key, required this.onRoleSelected});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   theme.colorScheme.primary.withOpacity(0.05),
//                   theme.scaffoldBackgroundColor,
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Spacer(),
//                   Text(
//                     'Choose Your Role',
//                     style: theme.textTheme.displaySmall,
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     'How will you be using the app?',
//                     style: theme.textTheme.bodyLarge,
//                   ),
//                   const SizedBox(height: 48),
//                   RoleCard(
//                     role: UserRole.student,
//                     onTap: () => onRoleSelected(UserRole.student),
//                   ),
//                   const SizedBox(height: 24),
//                   RoleCard(
//                     role: UserRole.mentor,
//                     onTap: () => onRoleSelected(UserRole.mentor),
//                   ),
//                   const Spacer(flex: 2),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // 3. Polished Sign Up Screen & 4. Login Screen (with shared widgets)
// class AuthScreenBase extends StatelessWidget {
//   final Widget child;
//   const AuthScreenBase({super.key, required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const AuthHeader(),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
//               child: child,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class SignUpScreen extends StatefulWidget {
//   final UserRole role;
//   final VoidCallback onLoginTapped;
//   const SignUpScreen({super.key, required this.role, required this.onLoginTapped});
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailCtrl = TextEditingController();
//   final _passwordCtrl = TextEditingController();
//   final _displayNameCtrl = TextEditingController();
//   final _schoolCtrl = TextEditingController();
//   bool _loading = false;
//
//   Future<void> _signup() async {
//     if (!_formKey.currentState!.validate()) return;
//     setState(() => _loading = true);
//
//     try {
//       if (!FirebaseService.isInitialized) {
//         throw StateError('Firebase is not configured. Run FlutterFire and enable Email/Password auth.');
//       }
//       await AuthService.signUpWithEmail(
//         _emailCtrl.text.trim(),
//         _passwordCtrl.text.trim(),
//         displayName: _displayNameCtrl.text.trim(),
//         school: _schoolCtrl.text.trim(),
//         role: widget.role,
//       );
//       if (mounted) Navigator.pushReplacementNamed(context, '/dashboard');
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Signup failed: $e'), backgroundColor: Colors.red),
//         );
//       }
//     } finally {
//       if (mounted) setState(() => _loading = false);
//     }
//   }
//
//   @override
//   void dispose() {
//     _emailCtrl.dispose();
//     _passwordCtrl.dispose();
//     _displayNameCtrl.dispose();
//     _schoolCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AuthScreenBase(
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text('Create Account', style: Theme.of(context).textTheme.headlineMedium),
//             const SizedBox(height: 24),
//             TextFormField(
//               controller: _displayNameCtrl,
//               decoration: const InputDecoration(labelText: 'Display Name', prefixIcon: Icon(Icons.person_outline_rounded)),
//               validator: (v) => v!.isNotEmpty ? null : 'Display name is required',
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _emailCtrl,
//               decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
//               validator: (v) => v!.contains('@') ? null : 'Invalid email',
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _passwordCtrl,
//               decoration: const InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock_outline_rounded)),
//               obscureText: true,
//               validator: (v) => v!.length >= 6 ? null : 'Password must be at least 6 characters',
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _schoolCtrl,
//               decoration: const InputDecoration(labelText: 'School/Institution', prefixIcon: Icon(Icons.school_outlined)),
//               validator: (v) => v!.isNotEmpty ? null : 'School required',
//             ),
//             const SizedBox(height: 32),
//             ElevatedButton(onPressed: _signup, child: _loading ? const CircularProgressIndicator(color: Colors.white) : const Text('Sign Up')),
//             const SizedBox(height: 24),
//             const _OrDivider(),
//             const SizedBox(height: 24),
//             const _SocialLoginButtons(),
//             const SizedBox(height: 24),
//             _BottomText(
//               text: 'Already have an account?',
//               buttonText: 'Login',
//               onPressed: widget.onLoginTapped,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class LoginScreen extends StatefulWidget {
//   final UserRole role;
//   final VoidCallback onSignUpTapped;
//
//   const LoginScreen({super.key, required this.role, required this.onSignUpTapped});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailCtrl = TextEditingController();
//   final _passwordCtrl = TextEditingController();
//   bool _loading = false;
//
//   Future<void> _login() async {
//     if (!_formKey.currentState!.validate()) return;
//     setState(() => _loading = true);
//
//     try {
//       await AuthService.signInWithEmail(_emailCtrl.text.trim(), _passwordCtrl.text.trim());
//       if (mounted) Navigator.pushReplacementNamed(context, '/dashboard');
//     } catch (e) {
//       if(mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Login failed: $e'), backgroundColor: Colors.red),
//         );
//       }
//     } finally {
//       if (mounted) setState(() => _loading = false);
//     }
//   }
//
//   @override
//   void dispose() {
//     _emailCtrl.dispose();
//     _passwordCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AuthScreenBase(
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text('Welcome Back', style: Theme.of(context).textTheme.headlineMedium),
//             const SizedBox(height: 24),
//             TextFormField(
//               controller: _emailCtrl,
//               decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
//               validator: (v) => v!.contains('@') ? null : 'Invalid email',
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _passwordCtrl,
//               decoration: const InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock_outline_rounded)),
//               obscureText: true,
//               validator: (v) => v!.isNotEmpty ? null : 'Password is required',
//             ),
//             const SizedBox(height: 32),
//             ElevatedButton(onPressed: _login, child: _loading ? const CircularProgressIndicator(color: Colors.white) : const Text('Login')),
//             const SizedBox(height: 24),
//             const _OrDivider(),
//             const SizedBox(height: 24),
//             const _SocialLoginButtons(),
//             const SizedBox(height: 24),
//             _BottomText(
//               text: "Don't have an account?",
//               buttonText: 'Sign Up',
//               onPressed: widget.onSignUpTapped,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // --- Shared Widgets for Auth Screens ---
//
// class AuthHeader extends StatelessWidget {
//   const AuthHeader({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return ClipPath(
//       clipper: WaveClipper(),
//       child: Container(
//         height: 250,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
//           child: Container(
//             color: Colors.black.withOpacity(0.1),
//             child: Center(
//               child: Lottie.asset('assets/lottie/animated_logo.json', width: 120, height: 120),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _BottomText extends StatelessWidget {
//   final String text;
//   final String buttonText;
//   final VoidCallback onPressed;
//
//   const _BottomText({required this.text, required this.buttonText, required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(text, style: theme.textTheme.bodyMedium),
//         TextButton(
//           onPressed: onPressed,
//           child: Text(
//             buttonText,
//             style: theme.textTheme.bodyMedium?.copyWith(
//                 color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class RoleCard extends StatefulWidget {
//   final UserRole role;
//   final VoidCallback onTap;
//
//   const RoleCard({super.key, required this.role, required this.onTap});
//
//   @override
//   State<RoleCard> createState() => _RoleCardState();
// }
//
// class _RoleCardState extends State<RoleCard> {
//   bool _isHovered = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return MouseRegion(
//       onEnter: (_) => setState(() => _isHovered = true),
//       onExit: (_) => setState(() => _isHovered = false),
//       child: GestureDetector(
//         onTap: widget.onTap,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             color: _isHovered
//                 ? theme.colorScheme.primary.withOpacity(0.05)
//                 : theme.colorScheme.surface,
//             borderRadius: BorderRadius.circular(24),
//             border: Border.all(
//               color: _isHovered
//                   ? theme.colorScheme.primary
//                   : theme.colorScheme.outline.withOpacity(0.2),
//               width: 1.5,
//             ),
//             boxShadow: _isHovered
//                 ? [
//               BoxShadow(
//                 color: theme.colorScheme.primary.withOpacity(0.1),
//                 blurRadius: 16,
//                 offset: const Offset(0, 8),
//               )
//             ]
//                 : [],
//           ),
//           child: Row(
//             children: [
//               Icon(widget.role.icon,
//                   size: 32,
//                   color: _isHovered
//                       ? theme.colorScheme.primary
//                       : theme.colorScheme.onSurface.withOpacity(0.7)),
//               const SizedBox(width: 20),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.role.displayName,
//                       style: theme.textTheme.titleLarge?.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: theme.colorScheme.onSurface,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       widget.role.description,
//                       style: theme.textTheme.bodyMedium?.copyWith(
//                         color: theme.colorScheme.onSurface.withOpacity(0.6),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Icon(Icons.arrow_forward_ios_rounded,
//                   size: 18,
//                   color: theme.colorScheme.onSurface.withOpacity(0.5)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class WaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.lineTo(0, size.height - 60);
//     var firstControlPoint = Offset(size.width / 4, size.height);
//     var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
//     path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
//         firstEndPoint.dx, firstEndPoint.dy);
//
//     var secondControlPoint =
//     Offset(size.width - (size.width / 3.25), size.height - 65);
//     var secondEndPoint = Offset(size.width, size.height - 40);
//     path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
//         secondEndPoint.dx, secondEndPoint.dy);
//
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
//
// class _OrDivider extends StatelessWidget {
//   const _OrDivider();
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Row(
//       children: [
//         Expanded(
//             child: Divider(color: theme.colorScheme.outline.withOpacity(0.3))),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Text(
//             'OR',
//             style: theme.textTheme.bodySmall
//                 ?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.5)),
//           ),
//         ),
//         Expanded(
//             child: Divider(color: theme.colorScheme.outline.withOpacity(0.3))),
//       ],
//     );
//   }
// }
//
// class _SocialLoginButtons extends StatelessWidget {
//   const _SocialLoginButtons();
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         _SocialButton(
//             asset: 'assets/images/google_logo.png', onPressed: () {}),
//         const SizedBox(width: 24),
//         _SocialButton(asset: 'assets/images/apple_logo.png', onPressed: () {}),
//       ],
//     );
//   }
// }
//
// class _SocialButton extends StatelessWidget {
//   final String asset;
//   final VoidCallback onPressed;
//   const _SocialButton({required this.asset, required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: theme.colorScheme.surface,
//           border:
//           Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             )
//           ],
//         ),
//         child: Image.asset(asset, width: 32, height: 32),
//       ),
//     );
//   }
// }













// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'dart:ui';
//
// import '../../models/user_profile.dart';
// import '../../services/auth_service.dart';
// import '../../services/firebase_service.dart';
//
// // --- MAIN PAGE: Orchestrates the entire Onboarding -> Auth flow ---
//
// class OnboardingAuthPage extends StatefulWidget {
//   const OnboardingAuthPage({super.key});
//
//   @override
//   State<OnboardingAuthPage> createState() => _OnboardingAuthPageState();
// }
//
// class _OnboardingAuthPageState extends State<OnboardingAuthPage> {
//   final PageController _pageController = PageController();
//   UserRole _selectedRole = UserRole.student;
//
//   void _navigateToPage(int page) {
//     _pageController.animateToPage(
//       page,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOutCubic,
//     );
//   }
//
//   void _onRoleSelected(UserRole role) {
//     setState(() {
//       _selectedRole = role;
//     });
//     // This now controls the inner PageView inside AuthFlowContainer
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: PageView(
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: [
//           OnboardingScreen(onGetStarted: () => _navigateToPage(1)),
//           AuthFlowContainer(
//             onRoleSelected: _onRoleSelected,
//             selectedRole: _selectedRole,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // --- 1. JAW-DROPPING ONBOARDING SCREEN ---
//
// class OnboardingScreen extends StatefulWidget {
//   final VoidCallback onGetStarted;
//   const OnboardingScreen({super.key, required this.onGetStarted});
//
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//
//   static const List<Map<String, String>> _onboardingData = [
//     {
//       "animation": "assets/lottie/mindful_shape.json",
//       "headline": "Find Your Center",
//       "description":
//       "Life as a student is demanding. Discover guided breathing and mindfulness exercises to find your calm amidst the chaos.",
//     },
//     {
//       "animation": "assets/lottie/growing_plant.json",
//       "headline": "Understand Your Journey",
//       "description":
//       "Your thoughts and feelings are valid. Our smart journal helps you track your mood patterns and reflect on your personal growth.",
//     },
//     {
//       "animation": "assets/lottie/supportive_hands.json",
//       "headline": "You Are Not Alone",
//       "description":
//       "Connect with a supportive community of peers and mentors. Share experiences and find strength in shared understanding.",
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background Animation
//           PageView.builder(
//             controller: _pageController,
//             itemCount: _onboardingData.length,
//             onPageChanged: (index) => setState(() => _currentPage = index),
//             itemBuilder: (_, index) =>
//                 AnimationBackground(asset: _onboardingData[index]['animation']!),
//           ),
//
//           // Glassmorphism UI panel
//           SafeArea(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 const Spacer(flex: 2),
//                 GlassmorphicPanel(
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: PageView.builder(
//                           physics: const NeverScrollableScrollPhysics(),
//                           controller: _pageController,
//                           itemCount: _onboardingData.length,
//                           itemBuilder: (_, index) => OnboardingTextContent(
//                             key: ValueKey('text_$index'),
//                             headline: _onboardingData[index]['headline']!,
//                             description: _onboardingData[index]['description']!,
//                           ),
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: List.generate(
//                           _onboardingData.length,
//                               (index) => buildDotIndicator(index),
//                         ),
//                       ),
//                       const SizedBox(height: 32),
//                       OnboardingActionButton(
//                         label: _currentPage == _onboardingData.length - 1
//                             ? 'Get Started'
//                             : 'Next',
//                         onPressed: () {
//                           if (_currentPage == _onboardingData.length - 1) {
//                             widget.onGetStarted();
//                           } else {
//                             _pageController.nextPage(
//                               duration: const Duration(milliseconds: 400),
//                               curve: Curves.easeInOut,
//                             );
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildDotIndicator(int index) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       margin: const EdgeInsets.symmetric(horizontal: 4),
//       height: 8,
//       width: _currentPage == index ? 24 : 8,
//       decoration: BoxDecoration(
//         color: _currentPage == index
//             ? Theme.of(context).colorScheme.primary
//             : Theme.of(context).colorScheme.primary.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(4),
//       ),
//     );
//   }
// }
//
// class AnimationBackground extends StatelessWidget {
//   final String asset;
//   const AnimationBackground({super.key, required this.asset});
//
//   @override
//   Widget build(BuildContext context) {
//     return Lottie.asset(
//       asset,
//       fit: BoxFit.cover,
//       width: double.infinity,
//       height: double.infinity,
//     );
//   }
// }
//
// class GlassmorphicPanel extends StatelessWidget {
//   final Widget child;
//   const GlassmorphicPanel({super.key, required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: const BorderRadius.only(
//         topLeft: Radius.circular(40),
//         topRight: Radius.circular(40),
//       ),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//         child: Container(
//           padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
//           height: 360, // Adjusted height to prevent overflow
//           decoration: BoxDecoration(
//             color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
//             border: Border(
//               top: BorderSide(
//                 color: Colors.white.withOpacity(0.2),
//               ),
//             ),
//           ),
//           child: child,
//         ),
//       ),
//     );
//   }
// }
//
// class OnboardingTextContent extends StatelessWidget {
//   final String headline;
//   final String description;
//
//   const OnboardingTextContent(
//       {super.key, required this.headline, required this.description});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(headline, style: theme.textTheme.displaySmall, textAlign: TextAlign.center),
//         const SizedBox(height: 16),
//         Text(description, style: theme.textTheme.bodyLarge, textAlign: TextAlign.center),
//       ],
//     );
//   }
// }
//
// class OnboardingActionButton extends StatelessWidget {
//   final String label;
//   final VoidCallback onPressed;
//
//   const OnboardingActionButton(
//       {super.key, required this.label, required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: theme.elevatedButtonTheme.style?.copyWith(
//         padding: MaterialStateProperty.all(
//           const EdgeInsets.symmetric(vertical: 18, horizontal: 80),
//         ),
//       ),
//       child: Text(label),
//     );
//   }
// }
//
// // --- AUTH FLOW CONTAINER & ROLE SELECTION ---
//
// class AuthFlowContainer extends StatefulWidget {
//   final Function(UserRole) onRoleSelected;
//   final UserRole selectedRole;
//
//   const AuthFlowContainer({
//     super.key,
//     required this.onRoleSelected,
//     required this.selectedRole,
//   });
//
//   @override
//   State<AuthFlowContainer> createState() => _AuthFlowContainerState();
// }
//
// class _AuthFlowContainerState extends State<AuthFlowContainer> {
//   final PageController _authPageController = PageController();
//
//   void _onRoleSelected(UserRole role) {
//     widget.onRoleSelected(role);
//     _authPageController.animateToPage(
//       1, // Navigate to Sign Up
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void _navigateToLogin() {
//     _authPageController.animateToPage(
//       2, // Navigate to Login
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void _navigateToSignUp() {
//     _authPageController.animateToPage(
//       1, // Navigate to SignUp
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PageView(
//       controller: _authPageController,
//       physics: const NeverScrollableScrollPhysics(),
//       children: [
//         RoleSelectionScreen(onRoleSelected: _onRoleSelected),
//         SignUpScreen(role: widget.selectedRole, onLoginTapped: _navigateToLogin),
//         LoginScreen(role: widget.selectedRole, onSignUpTapped: _navigateToSignUp),
//       ],
//     );
//   }
// }
//
// class RoleSelectionScreen extends StatelessWidget {
//   final Function(UserRole) onRoleSelected;
//
//   const RoleSelectionScreen({super.key, required this.onRoleSelected});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   theme.colorScheme.primary.withOpacity(0.05),
//                   theme.scaffoldBackgroundColor,
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Spacer(),
//                   Text(
//                     'Choose Your Role',
//                     style: theme.textTheme.displaySmall,
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     'How will you be using the app?',
//                     style: theme.textTheme.bodyLarge,
//                   ),
//                   const SizedBox(height: 48),
//                   RoleCard(
//                     role: UserRole.student,
//                     onTap: () => onRoleSelected(UserRole.student),
//                   ),
//                   const SizedBox(height: 24),
//                   RoleCard(
//                     role: UserRole.mentor,
//                     onTap: () => onRoleSelected(UserRole.mentor),
//                   ),
//                   const Spacer(flex: 2),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // --- AUTH SCREENS: LOGIN & SIGN UP ---
//
// class AuthScreenBase extends StatelessWidget {
//   final Widget child;
//   const AuthScreenBase({super.key, required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const AuthHeader(),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
//               child: child,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class SignUpScreen extends StatefulWidget {
//   final UserRole role;
//   final VoidCallback onLoginTapped;
//   const SignUpScreen({super.key, required this.role, required this.onLoginTapped});
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailCtrl = TextEditingController();
//   final _passwordCtrl = TextEditingController();
//   final _displayNameCtrl = TextEditingController();
//   final _schoolCtrl = TextEditingController();
//   bool _loading = false;
//
//   Future<void> _signup() async {
//     if (!_formKey.currentState!.validate()) return;
//     setState(() => _loading = true);
//
//     try {
//       if (!FirebaseService.isInitialized) {
//         throw StateError('Firebase is not configured. Run FlutterFire and enable Email/Password auth.');
//       }
//       await AuthService.signUpWithEmail(
//         _emailCtrl.text.trim(),
//         _passwordCtrl.text.trim(),
//         displayName: _displayNameCtrl.text.trim(),
//         school: _schoolCtrl.text.trim(),
//         role: widget.role,
//       );
//       if (mounted) Navigator.pushReplacementNamed(context, '/dashboard');
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Signup failed: $e'), backgroundColor: Colors.red),
//         );
//       }
//     } finally {
//       if (mounted) setState(() => _loading = false);
//     }
//   }
//
//   @override
//   void dispose() {
//     _emailCtrl.dispose();
//     _passwordCtrl.dispose();
//     _displayNameCtrl.dispose();
//     _schoolCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AuthScreenBase(
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text('Create Account', style: Theme.of(context).textTheme.headlineMedium),
//             const SizedBox(height: 24),
//             TextFormField(
//               controller: _displayNameCtrl,
//               decoration: const InputDecoration(labelText: 'Display Name', prefixIcon: Icon(Icons.person_outline_rounded)),
//               validator: (v) => v!.isNotEmpty ? null : 'Display name is required',
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _emailCtrl,
//               decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
//               validator: (v) => v!.contains('@') ? null : 'Invalid email',
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _passwordCtrl,
//               decoration: const InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock_outline_rounded)),
//               obscureText: true,
//               validator: (v) => v!.length >= 6 ? null : 'Password must be at least 6 characters',
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _schoolCtrl,
//               decoration: const InputDecoration(labelText: 'School/Institution', prefixIcon: Icon(Icons.school_outlined)),
//               validator: (v) => v!.isNotEmpty ? null : 'School required',
//             ),
//             const SizedBox(height: 32),
//             ElevatedButton(onPressed: _signup, child: _loading ? const CircularProgressIndicator(color: Colors.white) : const Text('Sign Up')),
//             const SizedBox(height: 24),
//             const _OrDivider(),
//             const SizedBox(height: 24),
//             const _SocialLoginButtons(),
//             const SizedBox(height: 24),
//             _BottomText(
//               text: 'Already have an account?',
//               buttonText: 'Login',
//               onPressed: widget.onLoginTapped,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class LoginScreen extends StatefulWidget {
//   final UserRole role;
//   final VoidCallback onSignUpTapped;
//
//   const LoginScreen({super.key, required this.role, required this.onSignUpTapped});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailCtrl = TextEditingController();
//   final _passwordCtrl = TextEditingController();
//   bool _loading = false;
//
//   Future<void> _login() async {
//     if (!_formKey.currentState!.validate()) return;
//     setState(() => _loading = true);
//
//     try {
//       await AuthService.signInWithEmail(_emailCtrl.text.trim(), _passwordCtrl.text.trim());
//       if (mounted) Navigator.pushReplacementNamed(context, '/dashboard');
//     } catch (e) {
//       if(mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Login failed: $e'), backgroundColor: Colors.red),
//         );
//       }
//     } finally {
//       if (mounted) setState(() => _loading = false);
//     }
//   }
//
//   @override
//   void dispose() {
//     _emailCtrl.dispose();
//     _passwordCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AuthScreenBase(
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text('Welcome Back', style: Theme.of(context).textTheme.headlineMedium),
//             const SizedBox(height: 24),
//             TextFormField(
//               controller: _emailCtrl,
//               decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
//               validator: (v) => v!.contains('@') ? null : 'Invalid email',
//             ),
//             const SizedBox(height: 16),
//             TextFormField(
//               controller: _passwordCtrl,
//               decoration: const InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock_outline_rounded)),
//               obscureText: true,
//               validator: (v) => v!.isNotEmpty ? null : 'Password is required',
//             ),
//             const SizedBox(height: 32),
//             ElevatedButton(onPressed: _login, child: _loading ? const CircularProgressIndicator(color: Colors.white) : const Text('Login')),
//             const SizedBox(height: 24),
//             const _OrDivider(),
//             const SizedBox(height: 24),
//             const _SocialLoginButtons(),
//             const SizedBox(height: 24),
//             _BottomText(
//               text: "Don't have an account?",
//               buttonText: 'Sign Up',
//               onPressed: widget.onSignUpTapped,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // --- SHARED WIDGETS AND HELPERS (ALL INCLUDED HERE) ---
//
// class RoleCard extends StatefulWidget {
//   final UserRole role;
//   final VoidCallback onTap;
//
//   const RoleCard({super.key, required this.role, required this.onTap});
//
//   @override
//   State<RoleCard> createState() => _RoleCardState();
// }
//
// class _RoleCardState extends State<RoleCard> {
//   bool _isHovered = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return MouseRegion(
//       onEnter: (_) => setState(() => _isHovered = true),
//       onExit: (_) => setState(() => _isHovered = false),
//       child: GestureDetector(
//         onTap: widget.onTap,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             color: _isHovered
//                 ? theme.colorScheme.primary.withOpacity(0.05)
//                 : theme.colorScheme.surface,
//             borderRadius: BorderRadius.circular(24),
//             border: Border.all(
//               color: _isHovered
//                   ? theme.colorScheme.primary
//                   : theme.colorScheme.outline.withOpacity(0.2),
//               width: 1.5,
//             ),
//             boxShadow: _isHovered
//                 ? [
//               BoxShadow(
//                 color: theme.colorScheme.primary.withOpacity(0.1),
//                 blurRadius: 16,
//                 offset: const Offset(0, 8),
//               )
//             ]
//                 : [],
//           ),
//           child: Row(
//             children: [
//               Icon(widget.role.icon,
//                   size: 32,
//                   color: _isHovered
//                       ? theme.colorScheme.primary
//                       : theme.colorScheme.onSurface.withOpacity(0.7)),
//               const SizedBox(width: 20),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.role.displayName,
//                       style: theme.textTheme.titleLarge?.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: theme.colorScheme.onSurface,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       widget.role.description,
//                       style: theme.textTheme.bodyMedium?.copyWith(
//                         color: theme.colorScheme.onSurface.withOpacity(0.6),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Icon(Icons.arrow_forward_ios_rounded,
//                   size: 18,
//                   color: theme.colorScheme.onSurface.withOpacity(0.5)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class WaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.lineTo(0, size.height - 60);
//     var firstControlPoint = Offset(size.width / 4, size.height);
//     var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
//     path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
//         firstEndPoint.dx, firstEndPoint.dy);
//
//     var secondControlPoint =
//     Offset(size.width - (size.width / 3.25), size.height - 65);
//     var secondEndPoint = Offset(size.width, size.height - 40);
//     path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
//         secondEndPoint.dx, secondEndPoint.dy);
//
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
//
// class AuthHeader extends StatelessWidget {
//   const AuthHeader({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return ClipPath(
//       clipper: WaveClipper(),
//       child: Container(
//         height: 250,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
//           child: Container(
//             color: Colors.black.withOpacity(0.1),
//             child: Center(
//               child: Lottie.asset('assets/lottie/animated_logo.json',
//                   width: 120, height: 120),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _OrDivider extends StatelessWidget {
//   const _OrDivider();
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Row(
//       children: [
//         Expanded(
//             child: Divider(color: theme.colorScheme.outline.withOpacity(0.3))),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Text(
//             'OR',
//             style: theme.textTheme.bodySmall
//                 ?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.5)),
//           ),
//         ),
//         Expanded(
//             child: Divider(color: theme.colorScheme.outline.withOpacity(0.3))),
//       ],
//     );
//   }
// }
//
// class _SocialLoginButtons extends StatelessWidget {
//   const _SocialLoginButtons();
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         _SocialButton(
//             asset: 'assets/images/google_logo.png', onPressed: () {}),
//         const SizedBox(width: 24),
//         _SocialButton(asset: 'assets/images/apple_logo.png', onPressed: () {}),
//       ],
//     );
//   }
// }
//
// class _SocialButton extends StatelessWidget {
//   final String asset;
//   final VoidCallback onPressed;
//   const _SocialButton({required this.asset, required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: theme.colorScheme.surface,
//           border:
//           Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             )
//           ],
//         ),
//         child: Image.asset(asset, width: 32, height: 32),
//       ),
//     );
//   }
// }
//
// class _BottomText extends StatelessWidget {
//   final String text;
//   final String buttonText;
//   final VoidCallback onPressed;
//
//   const _BottomText({required this.text, required this.buttonText, required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(text, style: theme.textTheme.bodyMedium),
//         TextButton(
//           onPressed: onPressed,
//           child: Text(
//             buttonText,
//             style: theme.textTheme.bodyMedium?.copyWith(
//                 color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }
// }
















import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:ui';

import '../../models/user_profile.dart';
import '../../services/auth_service.dart';
import '../../services/firebase_service.dart';

// --- MAIN PAGE: Orchestrates the entire Onboarding -> Auth flow ---

class OnboardingAuthPage extends StatefulWidget {
  const OnboardingAuthPage({super.key});

  @override
  State<OnboardingAuthPage> createState() => _OnboardingAuthPageState();
}

class _OnboardingAuthPageState extends State<OnboardingAuthPage> {
  final PageController _pageController = PageController();
  UserRole _selectedRole = UserRole.student;

  void _navigateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }

  void _onRoleSelected(UserRole role) {
    setState(() {
      _selectedRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          OnboardingScreen(onGetStarted: () => _navigateToPage(1)),
          AuthFlowContainer(
            onRoleSelected: _onRoleSelected,
            selectedRole: _selectedRole,
          ),
        ],
      ),
    );
  }
}

// --- 1. JAW-DROPPING ONBOARDING SCREEN (RE-ARCHITECTED) ---

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onGetStarted;
  const OnboardingScreen({super.key, required this.onGetStarted});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // FIX: Using two separate controllers to solve the "multiple PageViews" error.
  final PageController _backgroundController = PageController();
  final PageController _textController = PageController();
  int _currentPage = 0;

  static const List<Map<String, String>> _onboardingData = [
    {
      "animation": "assets/lottie/mindful_shape.json",
      "headline": "Find Your Center",
      "description":
      "Life as a student is demanding. Discover guided breathing and mindfulness exercises to find your calm amidst the chaos.",
    },
    {
      "animation": "assets/lottie/growing_plant.json",
      "headline": "Understand Your Journey",
      "description":
      "Your thoughts and feelings are valid. Our smart journal helps you track your mood patterns and reflect on your personal growth.",
    },
    {
      "animation": "assets/lottie/supportive_hands.json",
      "headline": "You Are Not Alone",
      "description":
      "Connect with a supportive community of peers and mentors. Share experiences and find strength in shared understanding.",
    },
  ];

  @override
  void initState() {
    super.initState();
    // Sync the controllers when one moves.
    _backgroundController.addListener(() {
      if (_textController.page?.round() !=
          _backgroundController.page?.round()) {
        _textController.animateToPage(
          _backgroundController.page!.round(),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
      if (mounted) {
        setState(() {
          _currentPage = _backgroundController.page?.round() ?? 0;
        });
      }
    });
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Animation PageView
          PageView.builder(
            controller: _backgroundController,
            itemCount: _onboardingData.length,
            itemBuilder: (_, index) => AnimationBackground(
                asset: _onboardingData[index]['animation']!),
          ),

          // Glassmorphism UI panel
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(flex: 2),
                GlassmorphicPanel(
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                          // This PageView is for text only and is controlled separately.
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _textController,
                          itemCount: _onboardingData.length,
                          itemBuilder: (_, index) => OnboardingTextContent(
                            key: ValueKey('text_$index'),
                            headline: _onboardingData[index]['headline']!,
                            description: _onboardingData[index]
                            ['description']!,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _onboardingData.length,
                              (index) => buildDotIndicator(index),
                        ),
                      ),
                      const SizedBox(height: 32),
                      OnboardingActionButton(
                        label: _currentPage == _onboardingData.length - 1
                            ? 'Get Started'
                            : 'Next',
                        onPressed: () {
                          if (_currentPage == _onboardingData.length - 1) {
                            widget.onGetStarted();
                          } else {
                            // This now correctly controls the background controller.
                            _backgroundController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDotIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class AnimationBackground extends StatelessWidget {
  final String asset;
  const AnimationBackground({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    // FIX: Using a SizedBox and BoxFit.contain to center and correctly scale the animation.
    return SizedBox.expand(
      child: Lottie.asset(
        asset,
        fit: BoxFit.contain, // This ensures the whole animation is visible
        alignment: Alignment.center,
      ),
    );
  }
}

class GlassmorphicPanel extends StatelessWidget {
  final Widget child;
  const GlassmorphicPanel({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
          height: 360, // FIX: Adjusted height to prevent overflow
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
            border: Border(
              top: BorderSide(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class OnboardingTextContent extends StatelessWidget {
  final String headline;
  final String description;

  const OnboardingTextContent(
      {super.key, required this.headline, required this.description});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(headline,
            style: theme.textTheme.displaySmall, textAlign: TextAlign.center),
        const SizedBox(height: 16),
        Text(description,
            style: theme.textTheme.bodyLarge, textAlign: TextAlign.center),
      ],
    );
  }
}

class OnboardingActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const OnboardingActionButton(
      {super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: theme.elevatedButtonTheme.style?.copyWith(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 18, horizontal: 80),
        ),
      ),
      child: Text(label),
    );
  }
}

// --- 2. PREMIUM ROLE SELECTION & AUTH FLOW CONTAINER ---

class AuthFlowContainer extends StatefulWidget {
  final Function(UserRole) onRoleSelected;
  final UserRole selectedRole;

  const AuthFlowContainer({
    super.key,
    required this.onRoleSelected,
    required this.selectedRole,
  });

  @override
  State<AuthFlowContainer> createState() => _AuthFlowContainerState();
}

class _AuthFlowContainerState extends State<AuthFlowContainer> {
  final PageController _authPageController = PageController();

  void _onRoleSelected(UserRole role) {
    widget.onRoleSelected(role);
    _authPageController.animateToPage(
      1, // Navigate to Sign Up page
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _navigateToLogin() {
    _authPageController.animateToPage(
      2, // Navigate to Login page
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _navigateToSignUp() {
    _authPageController.animateToPage(
      1, // Navigate back to Sign Up page
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // This inner PageView manages the flow between Role Selection, Sign Up, and Login
    return PageView(
      controller: _authPageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        RoleSelectionScreen(onRoleSelected: _onRoleSelected),
        SignUpScreen(
            role: widget.selectedRole, onLoginTapped: _navigateToLogin),
        LoginScreen(onSignUpTapped: _navigateToSignUp),
      ],
    );
  }
}

class RoleSelectionScreen extends StatelessWidget {
  final Function(UserRole) onRoleSelected;

  const RoleSelectionScreen({super.key, required this.onRoleSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          // Subtle background texture
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary.withOpacity(0.1),
                  theme.scaffoldBackgroundColor,
                  theme.scaffoldBackgroundColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: BackButton(
                        color: theme.colorScheme
                            .onSurface), // FIX: Used valid ColorScheme property
                  ),
                  const Spacer(),
                  Text(
                    'Join as a...',
                    style: theme.textTheme.displaySmall,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Choose your role to personalize your experience.',
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  RoleCard(
                    role: UserRole.student,
                    onTap: () => onRoleSelected(UserRole.student),
                  ),
                  const SizedBox(height: 24),
                  RoleCard(
                    role: UserRole.mentor,
                    onTap: () => onRoleSelected(UserRole.mentor),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- 3. POLISHED AUTH SCREENS (LOGIN & SIGN UP) ---

class AuthScreenBase extends StatelessWidget {
  final Widget child;
  const AuthScreenBase({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AuthHeader(),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  final UserRole role;
  final VoidCallback onLoginTapped;
  const SignUpScreen(
      {super.key, required this.role, required this.onLoginTapped});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _displayNameCtrl = TextEditingController();
  final _schoolCtrl = TextEditingController();
  bool _loading = false;

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    try {
      if (!FirebaseService.isInitialized) {
        throw StateError(
            'Firebase is not configured. Run FlutterFire and enable Email/Password auth.');
      }
      await AuthService.signUpWithEmail(
        _emailCtrl.text.trim(),
        _passwordCtrl.text.trim(),
        displayName: _displayNameCtrl.text.trim(),
        school: _schoolCtrl.text.trim(),
        role: widget.role,
      );
      if (mounted) Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Signup failed: $e'),
              backgroundColor: Theme.of(context).colorScheme.error),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _displayNameCtrl.dispose();
    _schoolCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreenBase(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Create Account',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 24),
            TextFormField(
              controller: _displayNameCtrl,
              decoration: const InputDecoration(
                  labelText: 'Display Name',
                  prefixIcon: Icon(Icons.person_outline_rounded)),
              validator: (v) => v!.isNotEmpty ? null : 'Display name is required',
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailCtrl,
              decoration: const InputDecoration(
                  labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
              validator: (v) => v!.contains('@') ? null : 'Invalid email',
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordCtrl,
              decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock_outline_rounded)),
              obscureText: true,
              validator: (v) =>
              v!.length >= 6 ? null : 'Password must be at least 6 characters',
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _schoolCtrl,
              decoration: const InputDecoration(
                  labelText: 'School/Institution',
                  prefixIcon: Icon(Icons.school_outlined)),
              validator: (v) => v!.isNotEmpty ? null : 'School required',
            ),
            const SizedBox(height: 32),
            ElevatedButton(
                onPressed: _loading ? null : _signup,
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Sign Up')),
            const SizedBox(height: 24),
            const _OrDivider(),
            const SizedBox(height: 24),
            const _SocialLoginButtons(),
            const SizedBox(height: 24),
            _BottomText(
              text: 'Already have an account?',
              buttonText: 'Login',
              onPressed: widget.onLoginTapped,
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  final VoidCallback onSignUpTapped;

  const LoginScreen({super.key, required this.onSignUpTapped});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _loading = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    try {
      await AuthService.signInWithEmail(
          _emailCtrl.text.trim(), _passwordCtrl.text.trim());
      if (mounted) Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Login failed: $e'),
              backgroundColor: Theme.of(context).colorScheme.error),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreenBase(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Welcome Back',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 24),
            TextFormField(
              controller: _emailCtrl,
              decoration: const InputDecoration(
                  labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
              validator: (v) => v!.contains('@') ? null : 'Invalid email',
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordCtrl,
              decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock_outline_rounded)),
              obscureText: true,
              validator: (v) => v!.isNotEmpty ? null : 'Password is required',
            ),
            const SizedBox(height: 32),
            ElevatedButton(
                onPressed: _loading ? null : _login,
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Login')),
            const SizedBox(height: 24),
            const _OrDivider(),
            const SizedBox(height: 24),
            const _SocialLoginButtons(),
            const SizedBox(height: 24),
            _BottomText(
              text: "Don't have an account?",
              buttonText: 'Sign Up',
              onPressed: widget.onSignUpTapped,
            ),
          ],
        ),
      ),
    );
  }
}

// --- SHARED WIDGETS AND HELPERS (ALL INCLUDED HERE) ---

class RoleCard extends StatefulWidget {
  final UserRole role;
  final VoidCallback onTap;

  const RoleCard({super.key, required this.role, required this.onTap});

  @override
  State<RoleCard> createState() => _RoleCardState();
}

class _RoleCardState extends State<RoleCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _isHovered
                ? theme.colorScheme.primary.withOpacity(0.05)
                : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.1),
                blurRadius: 16,
                offset: const Offset(0, 8),
              )
            ]
                : [],
          ),
          child: Row(
            children: [
              Icon(widget.role.icon,
                  size: 32,
                  color: _isHovered
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withOpacity(0.7)),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.role.displayName,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.role.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: theme.colorScheme.onSurface.withOpacity(0.5)),
            ],
          ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 60);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
    Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        height: 220, // Reduced height to fix overflow
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            color: Colors.black.withOpacity(0.1),
            child: Center(
              child: Lottie.asset('assets/lottie/animated_logo.json',
                  width: 120, height: 120),
            ),
          ),
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
            child: Divider(color: theme.colorScheme.outline.withOpacity(0.3))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.5)),
          ),
        ),
        Expanded(
            child: Divider(color: theme.colorScheme.outline.withOpacity(0.3))),
      ],
    );
  }
}

class _SocialLoginButtons extends StatelessWidget {
  const _SocialLoginButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialButton(
            asset: 'assets/images/google_logo.png', onPressed: () {}),
        const SizedBox(width: 24),
        _SocialButton(asset: 'assets/images/apple_logo.png', onPressed: () {}),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String asset;
  final VoidCallback onPressed;
  const _SocialButton({required this.asset, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.colorScheme.surface,
          border:
          Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Image.asset(asset, width: 32, height: 32),
      ),
    );
  }
}

class _BottomText extends StatelessWidget {
  final String text;
  final String buttonText;
  final VoidCallback onPressed;

  const _BottomText(
      {required this.text,
        required this.buttonText,
        required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: theme.textTheme.bodyMedium),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}






