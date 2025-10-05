import '../../app/constants/api_constants.dart';
import 'api_service.dart';

class ForgetPasswordService {
  /// Send reset password email
  static Future<Map<String, dynamic>> sendResetPasswordEmail({
    required String email,
  }) async {
    try {
      final response = await ApiService.postRequest(
        ApiConstants.sendResetPasswordEmail,
        body: {"email": email},
      );

      return {
        'success': true,
        'message': response['message'] ?? 'Reset email sent successfully',
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