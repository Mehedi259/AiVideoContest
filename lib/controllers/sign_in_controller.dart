//lib/controllers/sign_in_controller.dart
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
  final rememberMe = false.obs;

  final emailError = RxnString();
  final passwordError = RxnString();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  bool validateFields() {
    emailError.value = null;
    passwordError.value = null;

    bool valid = true;

    if (emailController.text.trim().isEmpty) {
      emailError.value = "Email is required";
      valid = false;
    } else if (!GetUtils.isEmail(emailController.text.trim())) {
      emailError.value = "Please enter a valid email";
      valid = false;
    }

    if (passwordController.text.isEmpty) {
      passwordError.value = "Password is required";
      valid = false;
    }

    return valid;
  }

  Future<void> login({required BuildContext context}) async {
    if (!validateFields()) return;

    isLoading.value = true;

    try {
      final result = await SignInService.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      developer.log('📦 Service Result: $result', name: 'SignInController');

      if (result['success'] == true) {
        Get.snackbar(
          'Success',
          result['message'] ?? 'Login successful!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );

        await Future.delayed(const Duration(milliseconds: 500));

        if (context.mounted) {
          context.go(Routes.home);
        }
      } else {
        passwordError.value = result['message'] ?? 'Login failed';
      }
    } catch (e) {
      developer.log('💥 Exception: $e', name: 'SignInController');
      passwordError.value = 'An error occurred. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }
}
