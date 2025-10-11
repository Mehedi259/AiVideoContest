import 'dart:developer' as developer;
import '../../app/constants/api_constants.dart';
import 'api_service.dart';

class ChangePasswordService {
  /// Change password
  static Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      final response = await ApiService.postRequest(
        ApiConstants.changePassword,
        body: {
          "current_password": currentPassword,
          "new_password": newPassword,
          "confirm_new_password": confirmNewPassword,
        },
      );

      developer.log('✅ Change Password Response: $response', name: 'ChangePasswordService');

      return {
        'success': true,
        'message': response['msg'] ?? 'Password changed successfully',
      };
    } catch (e) {
      developer.log('❌ Change Password Error: $e', name: 'ChangePasswordService');
      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }
}