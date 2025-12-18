import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;
import '../../app/constants/api_constants.dart';
import '../../app/utils/storage_helper.dart';
import 'api_service.dart';

class AppleSignInService {
  static Future<Map<String, dynamic>> signInWithApple() async {
    try {
      developer.log('🍎 Starting Apple Sign-In...', name: 'AppleSignInService');

      // Check if Apple Sign-In is available
      final isAvailable = await SignInWithApple.isAvailable();
      if (!isAvailable) {
        developer.log('❌ Apple Sign-In not available on this device', name: 'AppleSignInService');
        return {
          'success': false,
          'message': 'Apple Sign-In is not available on this device',
        };
      }

      AuthorizationCredentialAppleID credential;

      // For iOS - Native Sign-In (No web authentication needed)
      if (Platform.isIOS) {
        credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );
      } else {
        // For Android/Web - Use web authentication
        credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          webAuthenticationOptions: WebAuthenticationOptions(
            clientId: 'your.service.id',
            redirectUri: Uri.parse(
              'https://your-backend.com/callbacks/sign_in_with_apple',
            ),
          ),
        );
      }

      String? email = credential.email;
      final String? userIdentifier = credential.userIdentifier;
      final String? givenName = credential.givenName;
      final String? familyName = credential.familyName;

      developer.log('📧 Apple Email: $email', name: 'AppleSignInService');
      developer.log('🆔 Apple User ID: $userIdentifier', name: 'AppleSignInService');
      developer.log('👤 Name: $givenName $familyName', name: 'AppleSignInService');

      // Apple only provides email on the FIRST sign-in
      // On subsequent sign-ins, email will be null
      if (email == null || email.isEmpty) {
        developer.log('⚠️ Email not provided by Apple (subsequent login)', name: 'AppleSignInService');

        // You might want to store the email on first login using SharedPreferences
        // and retrieve it here for subsequent logins
        // For now, we'll return an error
        return {
          'success': false,
          'message': 'Email not available. This happens on subsequent logins. Please sign out from your Apple ID settings and try again, or use a different sign-in method.',
        };
      }

      // Send email to backend API
      final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.appleLogin}");

      developer.log('📤 POST Request to: $uri', name: 'AppleSignInService');
      developer.log('📦 Body: {"email": "$email"}', name: 'AppleSignInService');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": email,
        }),
      );

      developer.log('📥 Response Status: ${response.statusCode}', name: 'AppleSignInService');
      developer.log('📥 Response Body: ${response.body}', name: 'AppleSignInService');

      final responseData = ApiService.processResponse(response);

      if (responseData['success'] == true) {
        final accessToken = responseData['access'];
        final refreshToken = responseData['refresh'];

        if (accessToken != null) {
          await StorageHelper.saveToken(accessToken);
          developer.log('✅ Access token saved', name: 'AppleSignInService');
        }

        return {
          'success': true,
          'message': 'Apple login successful',
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
    } on SignInWithAppleAuthorizationException catch (e) {
      developer.log('💥 Apple Sign-In Authorization Error: ${e.code} - ${e.message}', name: 'AppleSignInService');

      String errorMessage;
      switch (e.code) {
        case AuthorizationErrorCode.canceled:
          errorMessage = 'Sign-in cancelled';
          break;
        case AuthorizationErrorCode.failed:
          errorMessage = 'Sign-in failed. Please try again.';
          break;
        case AuthorizationErrorCode.invalidResponse:
          errorMessage = 'Invalid response from Apple';
          break;
        case AuthorizationErrorCode.notHandled:
          errorMessage = 'Sign-in not handled properly';
          break;
        case AuthorizationErrorCode.unknown:
          errorMessage = 'Please enable Sign in with Apple in Xcode (Signing & Capabilities → + Capability → Sign in with Apple)';
          break;
        default:
          errorMessage = 'Sign-in error: ${e.message}';
      }

      return {
        'success': false,
        'message': errorMessage,
      };
    } catch (e) {
      developer.log('💥 Apple Sign-In Error: $e', name: 'AppleSignInService');
      return {
        'success': false,
        'message': 'An error occurred during Apple sign-in: $e',
      };
    }
  }

  /// Clear stored tokens
  static Future<void> signOut() async {
    try {
      await StorageHelper.clearToken();
      developer.log('🔴 Apple Sign-Out successful', name: 'AppleSignInService');
    } catch (e) {
      developer.log('💥 Apple Sign-Out Error: $e', name: 'AppleSignInService');
    }
  }
}