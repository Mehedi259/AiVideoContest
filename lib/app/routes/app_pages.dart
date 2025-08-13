import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../view/screens/auth/reset_confirm_screen.dart';
import '../../view/screens/auth/welcome_screen.dart';
import '../../view/screens/auth/sign_in_screen.dart';
import '../../view/screens/auth/sign_up_screen.dart';
import '../../view/screens/auth/forget_password_screen.dart';
import '../../view/screens/auth/otp_screen.dart';
import '../../view/screens/auth/update_password_screen.dart';
import 'app_routes.dart';

String _timestamp() {
  return DateFormat('HH:mm:ss').format(DateTime.now());
}

void _logRouteChange(String name, String path) {
  debugPrint('[ROUTE] ${_timestamp()} → $name ($path)');
}

class AppPages {
  static final router = GoRouter(
    initialLocation: Routes.welcome,
    routes: [
      GoRoute(
        path: Routes.welcome,
        name: 'Welcome Screen',
        builder: (context, state) {
          _logRouteChange('Welcome Screen', state.uri.toString());
          return WelcomeScreen();
        },
      ),
      GoRoute(
        path: Routes.signIn,
        name: 'Sign In Screen',
        builder: (context, state) {
          _logRouteChange('Sign In Screen', state.uri.toString());
          return const SignInScreen();
        },
      ),
      GoRoute(
        path: Routes.signUp,
        name: 'Sign Up Screen',
        builder: (context, state) {
          _logRouteChange('Sign Up Screen', state.uri.toString());
          return const SignUpScreen();
        },
      ),

      // *** Add forgetPassword route here ***
      GoRoute(
        path: Routes.forgetPassword,
        name: 'Forget Password Screen',
        builder: (context, state) {
          _logRouteChange('Forget Password Screen', state.uri.toString());
          return const ForgetPassword();
        },
      ),
      GoRoute(
        path: Routes.otp,
        name: 'OTP Screen',
        builder: (context, state) {
          _logRouteChange('OTP Screen', state.uri.toString());
          return const OtpScreen(email: '',);
        },
      ),
      GoRoute(
        path: Routes.passwordReset,
        name: 'Password Reset Screen',
        builder: (context, state) {
          _logRouteChange('Password Reset Screen', state.uri.toString());
          return const PasswordResetScreen();
        },
      ),
      GoRoute(
        path: Routes.updatePassword,
        name: 'Update Password Screen',
        builder: (context, state) {
          _logRouteChange('Update Password Screen', state.uri.toString());
          return const UpdatePasswordScreen();  // tumar update password screen class name
        },
      ),
    ],
  );
}
