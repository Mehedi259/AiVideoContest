import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/services/update_password_service.dart';

class UpdatePasswordController extends GetxController {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  String resetToken = '';

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  /// Set reset token from previous screen
  void setResetToken(String token) {
    resetToken = token;
  }

  /// Validate form fields
  bool _validateFields() {
    errorMessage.value = '';

    if (passwordController.text.isEmpty) {
      errorMessage.value = 'Password is required';
      return false;
    }

    if (passwordController.text.length < 8) {
      errorMessage.value = 'Password must be at least 8 characters';
      return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      errorMessage.value = 'Passwords do not match';
      return false;
    }

    if (resetToken.isEmpty) {
      errorMessage.value = 'Invalid reset token. Please try again.';
      return false;
    }

    return true;
  }

  /// Update password
  Future<bool> updatePassword() async {
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
      final result = await UpdatePasswordService.setNewPassword(
        resetToken: resetToken,
        newPassword: passwordController.text,
        newPassword2: confirmPasswordController.text,
      );

      if (result['success'] == true) {
        Get.snackbar(
          'Success',
          result['message'] ?? 'Password updated successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return true;
      } else {
        errorMessage.value = result['message'] ?? 'Failed to update password';
        Get.snackbar(
          'Error',
          errorMessage.value,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
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
