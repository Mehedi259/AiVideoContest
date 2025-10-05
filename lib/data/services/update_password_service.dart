import '../../app/constants/api_constants.dart';
import 'api_service.dart';

class UpdatePasswordService {
  /// Set new password after OTP verification
  static Future<Map<String, dynamic>> setNewPassword({
    required String resetToken,
    required String newPassword,
    required String newPassword2,
  }) async {
    try {
      final response = await ApiService.postRequest(
        ApiConstants.setNewPassword,
        body: {
          "reset_token": resetToken,
          "new_password": newPassword,
          "new_password2": newPassword2,
        },
      );

      return {
        'success': true,
        'message': response['message'] ?? 'Password updated successfully',
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