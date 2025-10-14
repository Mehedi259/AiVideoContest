import 'dart:developer' as developer;
import '../../app/constants/api_constants.dart';
import '../../app/utils/storage_helper.dart';
import 'api_service.dart';

class SignInService {
  /// Login user
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await ApiService.postRequest(
        ApiConstants.login,
        body: {
          "email": email,
          "password": password,
        },
      );

      developer.log('🔍 Login Response: $response', name: 'SignInService');

      // ✅ Handle nested token object
      String? accessToken;
      String? refreshToken;

      // Check if token is an object (nested)
      if (response['token'] != null && response['token'] is Map) {
        final tokenMap = response['token'] as Map<String, dynamic>;
        accessToken = tokenMap['access'] as String?;
        refreshToken = tokenMap['refresh'] as String?;
        developer.log(
          '✅ Found nested token - Access: ${accessToken?.substring(0, 20)}...',
          name: 'SignInService',
        );
      }
      // Check if token is directly a string
      else if (response['token'] != null && response['token'] is String) {
        accessToken = response['token'] as String;
        developer.log('✅ Found direct token', name: 'SignInService');
      }
      // Check for 'access' field directly
      else if (response['access'] != null) {
        accessToken = response['access'] as String;
        developer.log('✅ Found access token directly', name: 'SignInService');
      }
      // Check in data field
      else if (response['data'] != null && response['data'] is Map) {
        final dataMap = response['data'] as Map<String, dynamic>;
        if (dataMap['token'] != null && dataMap['token'] is Map) {
          final tokenMap = dataMap['token'] as Map<String, dynamic>;
          accessToken = tokenMap['access'] as String?;
          refreshToken = tokenMap['refresh'] as String?;
        } else if (dataMap['access'] != null) {
          accessToken = dataMap['access'] as String;
        }
      }

      // ✅ Save access token
      if (accessToken != null && accessToken.isNotEmpty) {
        await StorageHelper.saveToken(accessToken);
        developer.log('✅ Access token saved successfully', name: 'SignInService');
      } else {
        developer.log('⚠️ No access token found in response', name: 'SignInService');
      }

      // ✅ Optionally save refresh token (if needed)
      if (refreshToken != null && refreshToken.isNotEmpty) {
        developer.log('✅ Refresh token available', name: 'SignInService');
      }

      return {
        'success': true,
        'message': response['msg'] ??
            response['message'] ??
            'Login successful',
        'data': response,
        'access_token': accessToken,
        'refresh_token': refreshToken,
      };
    } catch (e) {
      developer.log('❌ Login Error: $e', name: 'SignInService');

      // 🧠 Friendly error message for users
      String message = e.toString();

      if (message.contains('404') &&
          message.contains('non_field_errors') &&
          message.contains('not Valid')) {
        message = 'Wrong email or password. Please try again.';
      } else if (message.contains('Failed host lookup')) {
        message = 'No internet connection. Please check your network.';
      } else if (message.contains('TimeoutException')) {
        message = 'Server timeout. Please try again later.';
      } else if (message.contains('500')) {
        message = 'Internal server error. Please try again later.';
      }

      return {
        'success': false,
        'message': message,
      };
    }
  }
}
