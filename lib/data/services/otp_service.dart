import '../../app/constants/api_constants.dart';
import 'api_service.dart';

class OtpService {
  /// Verify OTP for password reset
  static Future<Map<String, dynamic>> verifyResetPasswordOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await ApiService.postRequest(
        ApiConstants.resetPasswordOtp,
        body: {
          "email": email,
          "otp": otp,
        },
      );

      return {
        'success': true,
        'message': response['message'] ?? 'OTP verified successfully',
        'data': response,
        'reset_token': response['reset_token'], // Important for next step
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }

  /// Resend OTP for password reset
  static Future<Map<String, dynamic>> resendResetOtp({
    required String email,
  }) async {
    try {
      final response = await ApiService.postRequest(
        ApiConstants.sendResetPasswordEmail,
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