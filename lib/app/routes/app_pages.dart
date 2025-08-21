import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../view/screens/auth/password_updated_success_screen.dart';
import '../../view/screens/auth/reset_confirm_screen.dart';
import '../../view/screens/auth/welcome_screen.dart';
import '../../view/screens/auth/sign_in_screen.dart';
import '../../view/screens/auth/sign_up_screen.dart';
import '../../view/screens/auth/forget_password_screen.dart';
import '../../view/screens/auth/otp_screen.dart';
import '../../view/screens/auth/update_password_screen.dart';
import '../../view/screens/user_flow/badges_screen.dart';
import '../../view/screens/user_flow/change_password_screen.dart';
import '../../view/screens/user_flow/competetion_rules_screen.dart';
import '../../view/screens/user_flow/contact_feedback_screen.dart';
import '../../view/screens/user_flow/edit_profile_screen.dart';
import '../../view/screens/user_flow/home_screen.dart';
import '../../view/screens/user_flow/home_video_view_screen.dart';
import '../../view/screens/user_flow/liked_video_screen.dart';
import '../../view/screens/user_flow/my_account_screen.dart';
import '../../view/screens/user_flow/notification.dart';
import '../../view/screens/user_flow/profile_screen.dart';
import '../../view/screens/user_flow/upload_video_screen.dart';
import '../../view/screens/user_flow/uploaded_video_screen.dart';
import '../../view/screens/user_flow/voted_video_screen.dart';
import '../../view/screens/user_flow/winner_screen.dart';
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
          return const UpdatePasswordScreen();
        },
      ),
      GoRoute(
        path: Routes.success,
        name: 'Success Screen',
        builder: (context, state) {
          _logRouteChange('Success Screen', state.uri.toString());
          return SuccessScreen();
        },
      ),
      GoRoute(
        path: Routes.home,
        name: 'Home Screen',
        builder: (context, state) {
          _logRouteChange('Home Screen', state.uri.toString());
          return HomeScreen();
        },
      ),
      GoRoute(
        path: Routes.likedVideos,
        name: 'Liked Videos Screen',
        builder: (context, state) {
          _logRouteChange('Liked Videos Screen', state.uri.toString());
          return const LikedVideosScreen();
        },
      ),
      GoRoute(
        path: Routes.uploadVideos,
        name: 'Upload Video Screen',
        builder: (context, state) {
          _logRouteChange('Upload Video Screen', state.uri.toString());
          return const UploadVideoScreen();
        },
      ),
      GoRoute(
        path: Routes.winner,
        name: 'Winner Screen',
        builder: (context, state) {
          _logRouteChange('Winner Screen', state.uri.toString());
          return const WinnerScreen();
        },
      ),
      GoRoute(
        path: Routes.profile,
        name: 'profile Screen',
        builder: (context, state) {
          _logRouteChange('profile Screen', state.uri.toString());
          return const ProfileScreen();
        },
      ),
      GoRoute(
        path: Routes.competition,
        builder: (context, state) => const CompetetionRulesScreen(),
      ),
      GoRoute(
        path: Routes.feedback,
        builder: (context, state) => const ContactFeedbackScreen(),
      ),
      GoRoute(
        path: Routes.editInformation,
        builder: (context, state) => const EditInformationScreen(),
      ),
      GoRoute(
        path: Routes.changePassword,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: Routes.ProfileScreen,
        builder: (context, state) => const MyAccountScreen(),
      ),
      GoRoute(
        path: Routes.myAccount,
        builder: (context, state) => const MyAccountScreen(),
      ),
      GoRoute(
        path: Routes.uploadedVideos,
        builder: (context, state) => const UploadedVideoScreen(),
      ),
      GoRoute(
        path: Routes.votedVideos,
        builder: (context, state) => const VotedVideoScreen(),
      ),
      GoRoute(
        path: Routes.badges,
        builder: (context, state) => const BadgeScreen(),
      ),
      GoRoute(
        path: Routes.videoPlay,
        builder: (context, state) => const VideoDetailScreen(),
      ),
      GoRoute(
        path: Routes.notification,
        builder: (context, state) => const NotificationScreen(),
      ),







    ],
  );
}
