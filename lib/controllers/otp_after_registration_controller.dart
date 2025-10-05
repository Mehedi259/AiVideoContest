import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/services/otp_after_registration_service.dart';

class OtpAfterRegistrationController extends GetxController {
  final otpController = TextEditingController();
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  String email = '';

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }

  /// Set email from previous screen
  void setEmail(String userEmail) {
    email = userEmail;
  }

  /// Verify OTP
  Future<bool> verifyOtp() async {
    if (otpController.text.trim().length != 6) {
      Get.snackbar(
        'Invalid OTP',
        'Please enter a 6-digit OTP',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }

    isLoading.value = true;

    try {
      final result = await OtpAfterRegistrationService.verifyOtp(
        email: email,
        otp: otpController.text.trim(),
      );

      if (result['success'] == true) {
        Get.snackbar(
          'Success',
          result['message'] ?? 'Account verified successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return true;
      } else {
        errorMessage.value = result['message'] ?? 'Invalid OTP';
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

  /// Resend OTP
  Future<void> resendOtp() async {
    isLoading.value = true;

    try {
      final result = await OtpAfterRegistrationService.resendOtp(email: email);

      if (result['success'] == true) {
        Get.snackbar(
          'Success',
          'OTP has been resent to your email',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        Get.snackbar(
          'Error',
          result['message'] ?? 'Failed to resend OTP',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to resend OTP',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }
}