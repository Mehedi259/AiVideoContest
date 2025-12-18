import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../data/services/apple_sign_in_service.dart';
import '../app/routes/app_routes.dart';

class AppleSignInController extends GetxController {
  final isLoading = false.obs;

  Future<void> signInWithApple({required BuildContext context}) async {
    isLoading.value = true;

    try {
      // Call Apple Sign-In Service
      final result = await AppleSignInService.signInWithApple();

      developer.log('📦 Apple Sign-In Result: $result', name: 'AppleSignInController');

      if (result['success'] == true) {
        // Show success message using ScaffoldMessenger instead of GetX snackbar
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Apple login successful!'),
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
              content: Text(result['message'] ?? 'Apple login failed'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    } catch (e) {
      developer.log('💥 Apple Sign-In Exception: $e', name: 'AppleSignInController');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred during Apple sign-in'),
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