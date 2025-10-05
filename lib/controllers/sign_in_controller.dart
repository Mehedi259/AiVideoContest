// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
// import '../data/services/sign_in_service.dart';
// import '../app/routes/app_routes.dart';
//
// class SignInController extends GetxController {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   final isLoading = false.obs;
//   final errorMessage = ''.obs;
//   final rememberMe = false.obs;
//
//   @override
//   void onClose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.onClose();
//   }
//
//   /// Toggle remember me
//   void toggleRememberMe() {
//     rememberMe.value = !rememberMe.value;
//   }
//
//   /// Validate form fields
//   bool _validateFields() {
//     errorMessage.value = '';
//
//     if (emailController.text.trim().isEmpty) {
//       errorMessage.value = 'Email is required';
//       return false;
//     }
//
//     if (!GetUtils.isEmail(emailController.text.trim())) {
//       errorMessage.value = 'Please enter a valid email';
//       return false;
//     }
//
//     if (passwordController.text.isEmpty) {
//       errorMessage.value = 'Password is required';
//       return false;
//     }
//
//     return true;
//   }
//
//   /// Login user
//   Future<void> login({required BuildContext context}) async {
//     if (!_validateFields()) {
//       Get.snackbar(
//         'Validation Error',
//         errorMessage.value,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//         snackPosition: SnackPosition.TOP,
//       );
//       return;
//     }
//
//     isLoading.value = true;
//
//     try {
//       final result = await SignInService.login(
//         email: emailController.text.trim(),
//         password: passwordController.text,
//       );
//
//       if (result['success'] == true) {
//         Get.snackbar(
//           'Success',
//           result['message'] ?? 'Login successful!',
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//           snackPosition: SnackPosition.TOP,
//         );
//
//         // ✅ Navigate to Home after successful login
//         context.go(Routes.home);
//       } else {
//         errorMessage.value = result['message'] ?? 'Login failed';
//         Get.snackbar(
//           'Error',
//           errorMessage.value,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           snackPosition: SnackPosition.TOP,
//         );
//       }
//     } catch (e) {
//       errorMessage.value = 'An error occurred. Please try again.';
//       Get.snackbar(
//         'Error',
//         errorMessage.value,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//         snackPosition: SnackPosition.TOP,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../data/services/sign_in_service.dart';
import '../app/routes/app_routes.dart';

class SignInController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final rememberMe = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  /// Toggle remember me
  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  /// Validate form fields
  bool _validateFields() {
    errorMessage.value = '';

    if (emailController.text.trim().isEmpty) {
      errorMessage.value = 'Email is required';
      return false;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      errorMessage.value = 'Please enter a valid email';
      return false;
    }

    if (passwordController.text.isEmpty) {
      errorMessage.value = 'Password is required';
      return false;
    }

    return true;
  }

  /// Login user
  Future<void> login({required BuildContext context}) async {
    developer.log('🚀 Login started', name: 'SignInController');

    if (!_validateFields()) {
      Get.snackbar(
        'Validation Error',
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    isLoading.value = true;

    try {
      final result = await SignInService.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      developer.log('📦 Service Result: $result', name: 'SignInController');

      // ✅ Check if API call was successful (no exception = success)
      if (result['success'] == true) {
        developer.log('✅ Login successful, navigating to home', name: 'SignInController');

        Get.snackbar(
          'Success',
          result['message'] ?? 'Login successful!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );

        // ✅ Wait a moment for snackbar to show, then navigate
        await Future.delayed(const Duration(milliseconds: 500));

        // ✅ Navigate to Home
        if (context.mounted) {
          developer.log('🏠 Navigating to: ${Routes.home}', name: 'SignInController');
          context.go(Routes.home);
        }
      } else {
        developer.log('❌ Login failed: ${result['message']}', name: 'SignInController');
        errorMessage.value = result['message'] ?? 'Login failed';
        Get.snackbar(
          'Error',
          errorMessage.value,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      developer.log('💥 Exception: $e', name: 'SignInController');
      errorMessage.value = 'An error occurred. Please try again.';
      Get.snackbar(
        'Error',
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }
}