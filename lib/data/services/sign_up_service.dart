import '../../app/constants/api_constants.dart';
import 'api_service.dart';

class SignUpService {
  /// Register a new user
  static Future<Map<String, dynamic>> register({
    required String fullname,
    required String username,
    required String email,
    required String password,
    required String password2,
  }) async {
    try {
      final response = await ApiService.postRequest(
        ApiConstants.register,
        body: {
          "fullname": fullname,
          "username": username,
          "email": email,
          "password": password,
          "password2": password2,
        },
      );

      return {
        'success': true,
        'message': response['message'] ?? 'Registration successful',
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