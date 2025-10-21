import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../services/firebase_service.dart';
import '../../models/user_profile.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _displayNameCtrl = TextEditingController();
  final _schoolCtrl = TextEditingController();
  bool _loading = false;
  UserRole? _selectedRole;
  late AnimationController _fadeController;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fade = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _fadeController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get selected role from arguments
    if (_selectedRole == null) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      _selectedRole = args?['selectedRole'] as UserRole?;
    }
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _displayNameCtrl.dispose();
    _schoolCtrl.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a role to continue.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    setState(() => _loading = true);
    
    try {
      if (!FirebaseService.isInitialized) {
        throw StateError('Firebase is not configured. Run FlutterFire and enable Email/Password auth.');
      }
      await AuthService.signUpWithEmail(
        _emailCtrl.text.trim(), 
        _passwordCtrl.text.trim(),
        displayName: _displayNameCtrl.text.trim(),
        school: _schoolCtrl.text.trim(),
        role: _selectedRole!,
      );
      
      if (!mounted) return;
      setState(() => _loading = false);
      
      // Navigate to dashboard after successful signup
      Navigator.pushReplacementNamed(context, '/dashboard');
      
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signup failed: ${_friendlyError(e)}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _friendlyError(Object e) {
    final msg = e.toString();
    if (msg.contains('weak-password')) {
      return 'Password is too weak.';
    }
    if (msg.contains('email-already-in-use')) {
      return 'That email is already in use.';
    }
    if (msg.contains('invalid-email')) {
      return 'Email address is invalid.';
    }
    if (msg.contains('Firebase is not configured')) {
      return 'App not connected to Firebase. See README to configure Firebase.';
    }
    return msg;
  }

  @override
  Widget build(BuildContext context) {
  final theme = Theme.of(context);
  return Scaffold(
  body: Container(
  decoration: BoxDecoration(
  gradient: LinearGradient(
  colors: [
    theme.colorScheme.secondary.withValues(alpha: 0.1),
  theme.colorScheme.primary.withValues(alpha: 0.05),
  theme.scaffoldBackgroundColor,
  ],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  ),
  ),
  child: SafeArea(
  child: Center(
  child: SingleChildScrollView(
  padding: const EdgeInsets.all(24),
  child: FadeTransition(
  opacity: _fade,
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
  // Animated Logo Section
  Container(
  height: 120,
    alignment: Alignment.center,
      child: Container(
        width: 120,
        height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
          theme.colorScheme.secondary,
          theme.colorScheme.primary,
          ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
          color: theme.colorScheme.secondary.withValues(alpha: 0.3),
            blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
      ),
      child: const Icon(
      Icons.group_add_rounded,
    color: Colors.white,
  size: 48,
  ),
  ),
  ),
  const SizedBox(height: 24),
  Text(
  'Join Our Community',
  textAlign: TextAlign.center,
  style: theme.textTheme.displaySmall?.copyWith(
  fontWeight: FontWeight.w900,
  color: theme.colorScheme.onSurface,
  letterSpacing: -0.5,
  ),
  ),
  const SizedBox(height: 12),
  Text(
  'Create your account and start your wellness journey',
  textAlign: TextAlign.center,
  style: theme.textTheme.bodyLarge?.copyWith(
  color: theme.colorScheme.onSurface.withOpacity(0.7),
  height: 1.5,
  ),
  ),
  const SizedBox(height: 48),
  // Form Card
  Container(
  padding: const EdgeInsets.all(32),
  decoration: BoxDecoration(
  color: theme.colorScheme.surface,
  borderRadius: BorderRadius.circular(24),
  boxShadow: [
  BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ],
  ),
  child: Form(
  key: _formKey,
  child: Column(
  children: [
    DropdownButtonFormField<UserRole>(
        value: _selectedRole,
        style: TextStyle(color: theme.colorScheme.onSurface),
        decoration: InputDecoration(
          labelText: 'Choose Your Role',
          hintText: 'Select student or mentor',
          prefixIcon: Icon(
       Icons.badge_outlined,
       color: theme.colorScheme.primary,
       ),
       border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(16),
          ),
        ),
      items: [
        DropdownMenuItem(
        value: UserRole.student,
        child: Text(
      'Student',
  style: TextStyle(color: theme.colorScheme.onSurface),
  ),
  ),
  DropdownMenuItem(
    value: UserRole.mentor,
          child: Text(
              'Mentor',
                style: TextStyle(color: theme.colorScheme.onSurface),
                ),
                ),
              ],
              onChanged: _loading ? null : (role) => setState(() => _selectedRole = role),
            validator: (role) => role == null ? 'Please select a role' : null,
        ),
        const SizedBox(height: 20),
        TextFormField(
            controller: _displayNameCtrl,
            style: TextStyle(color: theme.colorScheme.onSurface),
              decoration: InputDecoration(
                  labelText: 'Display Name',
                    hintText: 'How others will see you',
                      prefixIcon: Icon(
                          Icons.person_outline,
                            color: theme.colorScheme.primary,
                            ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              validator: (v) => v != null && v.isNotEmpty ? null : 'Display name is required',
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: theme.colorScheme.onSurface),
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                                hintText: 'Enter your email',
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: theme.colorScheme.primary,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              validator: (v) => v != null && v.contains('@') ? null : 'Please enter a valid email',
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _passwordCtrl,
                              style: TextStyle(color: theme.colorScheme.onSurface),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Create a strong password',
                                prefixIcon: Icon(
                                  Icons.lock_outline_rounded,
                                  color: theme.colorScheme.primary,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              obscureText: true,
                              validator: (v) => (v != null && v.length >= 6) ? null : 'Password must be at least 6 characters',
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _schoolCtrl,
                              style: TextStyle(color: theme.colorScheme.onSurface),
                              decoration: InputDecoration(
                                labelText: 'School/Institution',
                                hintText: 'Where do you study or work?',
                                prefixIcon: Icon(
                                  Icons.school_outlined,
                                  color: theme.colorScheme.primary,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              validator: (v) => v != null && v.isNotEmpty ? null : 'School/Institution is required',
                            ),
                            const SizedBox(height: 32),
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: _loading ? null : _signup,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.secondary,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 0,
                                ),
                                child: _loading
                                    ? const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        'Create Account',
                                        style: theme.textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushReplacementNamed(
                            context,
                            '/login',
                            arguments: {'selectedRole': _selectedRole},
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: theme.colorScheme.secondary,
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


