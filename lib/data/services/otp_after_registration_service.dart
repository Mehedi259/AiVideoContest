import '../../app/constants/api_constants.dart';
import 'api_service.dart';

class OtpAfterRegistrationService {
  /// Verify OTP after registration
  static Future<Map<String, dynamic>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await ApiService.postRequest(
        ApiConstants.verifyOtp,
        body: {
          "email": email,
          "otp": otp,
        },
      );

      return {
        'success': true,
        'message': response['message'] ?? 'OTP verified successfully',
        'data': response,
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }

  /// Resend OTP (if backend supports)
  static Future<Map<String, dynamic>> resendOtp({
    required String email,
  }) async {
    try {
      // Note: Adjust endpoint if your backend has a different resend endpoint
      final response = await ApiService.postRequest(
        ApiConstants.register, // Or use a dedicated resend endpoint
        body: {"email": email},
      );

      return {
        'success': true,
        'message': 'OTP resent successfully',
        'data': response,
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }
}