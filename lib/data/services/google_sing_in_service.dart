//lib/data/services/google_sing_in_service.dart
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../../app/constants/api_constants.dart';
import '../../app/utils/storage_helper.dart';
import 'api_service.dart';

class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  static Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      developer.log('🔵 Starting Google Sign-In...', name: 'GoogleSignInService');

      // Trigger Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        developer.log('❌ User cancelled Google Sign-In', name: 'GoogleSignInService');
        return {
          'success': false,
          'message': 'Sign-in cancelled',
        };
      }

      final String email = googleUser.email;
      developer.log('📧 Google Email: $email', name: 'GoogleSignInService');

      // Send email to backend API
      final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.googleLogin}");

      developer.log('📤 POST Request to: $uri', name: 'GoogleSignInService');
      developer.log('📦 Body: {"email": "$email"}', name: 'GoogleSignInService');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": email,
        }),
      );

      developer.log('📥 Response Status: ${response.statusCode}', name: 'GoogleSignInService');
      developer.log('📥 Response Body: ${response.body}', name: 'GoogleSignInService');

      final responseData = ApiService.processResponse(response);

      if (responseData['success'] == true) {
        final accessToken = responseData['access'];
        final refreshToken = responseData['refresh'];

        if (accessToken != null) {
          await StorageHelper.saveToken(accessToken);
          developer.log('✅ Access token saved', name: 'GoogleSignInService');
        }

        return {
          'success': true,
          'message': 'Google login successful',
          'access': accessToken,
          'refresh': refreshToken,
          'created': responseData['created'] ?? false,
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Login failed',
        };
      }
    } catch (e) {
      developer.log('💥 Google Sign-In Error: $e', name: 'GoogleSignInService');
      return {
        'success': false,
        'message': 'An error occurred: $e',
      };
    }
  }

  /// Sign out from Google
  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await StorageHelper.clearToken();
      developer.log('🔴 Google Sign-Out successful', name: 'GoogleSignInService');
    } catch (e) {
      developer.log('💥 Google Sign-Out Error: $e', name: 'GoogleSignInService');
    }
  }
}