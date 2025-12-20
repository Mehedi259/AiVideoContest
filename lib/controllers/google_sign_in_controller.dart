//lib/controllers/google_sign_in_controller.dart
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../data/services/google_sing_in_service.dart';
import '../app/routes/app_routes.dart';

class GoogleSignInController extends GetxController {
  final isLoading = false.obs;

  Future<void> signInWithGoogle({required BuildContext context}) async {
    isLoading.value = true;

    try {
      // Call Google Sign-In Service
      final result = await GoogleSignInService.signInWithGoogle();

      developer.log('📦 Google Sign-In Result: $result', name: 'GoogleSignInController');

      if (result['success'] == true) {
        // Show success message using ScaffoldMessenger instead of GetX snackbar
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Google login successful!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );

          await Future.delayed(const Duration(milliseconds: 500));
          context.go(Routes.home);
        }
      } else {
        // Show error message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] ?? 'Google login failed'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    } catch (e) {
      developer.log('💥 Google Sign-In Exception: $e', name: 'GoogleSignInController');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred during Google sign-in'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }
}