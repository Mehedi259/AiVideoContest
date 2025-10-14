import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/services/sign_up_service.dart';

class SignUpController extends GetxController {
  final fullnameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onClose() {
    fullnameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  /// ✅ Strong password validation rule
  bool _isStrongPassword(String password) {
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigit = password.contains(RegExp(r'\d'));
    final hasSpecialChar = password.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'));
    final hasMinLength = password.length >= 8;

    return hasUppercase && hasLowercase && hasDigit && hasSpecialChar && hasMinLength;
  }

  /// Validate form fields
  bool _validateFields() {
    errorMessage.value = '';

    if (fullnameController.text.trim().isEmpty) {
      errorMessage.value = 'Full name is required';
      return false;
    }

    if (usernameController.text.trim().isEmpty) {
      errorMessage.value = 'Username is required';
      return false;
    }

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

    /// ✅ Weak password check
    if (!_isStrongPassword(passwordController.text)) {
      errorMessage.value =
      'Password is too weak. Use at least 8 characters including upper, lower, number & special symbol.';
      return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      errorMessage.value = 'Passwords do not match';
      return false;
    }

    return true;
  }

  /// Register user
  Future<bool> register() async {
    if (!_validateFields()) {
      Get.snackbar(
        'Validation Error',
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }

    isLoading.value = true;

    try {
      final result = await SignUpService.register(
        fullname: fullnameController.text.trim(),
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        password2: confirmPasswordController.text,
      );

      if (result['success'] == true) {
        Get.snackbar(
          'Success',
          result['message'] ?? 'Registration successful! Please verify your email.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return true;
      } else {
        errorMessage.value = result['message'] ?? 'Registration failed';
        Get.snackbar(
          'Error',
          errorMessage.value,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
        );
        return false;
      }
    } catch (e) {
      errorMessage.value = 'An error occurred. Please try again.';
      Get.snackbar(
        'Error',
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
