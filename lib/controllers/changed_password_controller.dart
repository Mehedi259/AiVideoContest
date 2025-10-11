import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/services/changed_password_service.dart';

class ChangePasswordController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  /// Validate password fields
  bool _validateFields() {
    errorMessage.value = '';

    if (currentPasswordController.text.isEmpty) {
      errorMessage.value = 'Current password is required';
      return false;
    }

    if (newPasswordController.text.isEmpty) {
      errorMessage.value = 'New password is required';
      return false;
    }

    if (newPasswordController.text.length < 6) {
      errorMessage.value = 'New password must be at least 6 characters';
      return false;
    }

    if (confirmPasswordController.text.isEmpty) {
      errorMessage.value = 'Confirm password is required';
      return false;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      errorMessage.value = 'Passwords do not match';
      return false;
    }

    if (currentPasswordController.text == newPasswordController.text) {
      errorMessage.value = 'New password must be different from current password';
      return false;
    }

    return true;
  }

  /// Change password
  Future<void> changePassword() async {
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
      final result = await ChangePasswordService.changePassword(
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
        confirmNewPassword: confirmPasswordController.text,
      );

      if (result['success'] == true) {
        Get.snackbar(
          'Success',
          result['message'] ?? 'Password changed successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );

        // Clear fields
        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();

        // Navigate back after delay
        await Future.delayed(const Duration(milliseconds: 500));
        Get.back();
      } else {
        errorMessage.value = result['message'] ?? 'Password change failed';
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
      developer.log('❌ Change Password Error: $e', name: 'ChangePasswordController');
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