// lib/view/screens/auth/welcome_screen.dart
import 'package:flutter/material.dart';
import 'package:Prommt/gen/assets.gen.dart';
import 'package:Prommt/view/widgets/active_button.dart';
import 'package:go_router/go_router.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/utils/storage_helper.dart';

/// -----------------------------
/// Welcome Screen with Auto-Login
/// -----------------------------
/// This is the first screen of the app.
/// - Checks if user has token
/// - If token exists → redirects to Home
/// - If no token → shows Sign in/Sign up buttons
/// -----------------------------
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isCheckingAuth = true;

  @override
  void initState() {
    super.initState();
    _checkAuthenticationStatus();
  }

  /// ✅ Token check করে auto-login
  Future<void> _checkAuthenticationStatus() async {
    // Small delay for smooth UX (optional)
    await Future.delayed(const Duration(milliseconds: 800));

    // Check if token exists
    final token = await StorageHelper.getToken();

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      // ✅ Token আছে → সরাসরি Home-এ redirect
      debugPrint('✅ Token found! Redirecting to Home...');
      context.go(Routes.home);
    } else {
      // ❌ Token নেই → Welcome Screen দেখাও
      debugPrint('❌ No token found. Showing Welcome Screen...');
      setState(() {
        _isCheckingAuth = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _isCheckingAuth
            ? _buildLoadingScreen()
            : _buildWelcomeContent(context),
      ),
    );
  }

  /// Loading screen যখন token check হচ্ছে
  Widget _buildLoadingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.mainLogo.image(
            width: 170,
            height: 124,
          ),
          const SizedBox(height: 40),
          const CircularProgressIndicator(
            color: Color(0xFF004AAD),
            strokeWidth: 3,
          ),
        ],
      ),
    );
  }

  /// Welcome Screen এর main content
  Widget _buildWelcomeContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 200),

            /// App Logo
            Center(
              child: Assets.images.mainLogo.image(
                width: 170,
                height: 124,
              ),
            ),

            const SizedBox(height: 250),

            /// Sign up button
            ActiveButton(
              text: 'Sign up',
              onPressed: () {
                context.push(Routes.signUp);
              },
            ),
            const SizedBox(height: 10),

            /// Sign in button
            SizedBox(
              height: 50.0,
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF004AAD),
                  side: const BorderSide(color: Color(0xFF004AAD), width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  context.push(Routes.signIn);
                },
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}