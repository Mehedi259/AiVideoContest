import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../app/constants/api_constants.dart';
import '../../app/utils/storage_helper.dart';
import '../models/profile_model.dart';
import 'api_service.dart';

class ProfileService {
  /// Fetch user profile
  static Future<Map<String, dynamic>> fetchProfile() async {
    try {
      final response = await ApiService.getRequest(ApiConstants.profile);
      developer.log('📦 Profile Response: $response', name: 'ProfileService');

      final profile = ProfileModel.fromJson(response);
      return {
        'success': true,
        'profile': profile,
      };
    } catch (e) {
      developer.log('❌ Fetch Profile Error: $e', name: 'ProfileService');
      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }

  /// Fetch vote count
  static Future<Map<String, dynamic>> fetchVoteCount() async {
    try {
      final response = await ApiService.getRequest(ApiConstants.votes);
      developer.log('📦 Vote Count Response: $response', name: 'ProfileService');

      final voteCount = VoteCountModel.fromJson(response);
      return {
        'success': true,
        'voteCount': voteCount,
      };
    } catch (e) {
      developer.log('❌ Fetch Vote Count Error: $e', name: 'ProfileService');
      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }

  /// Update profile
  static Future<Map<String, dynamic>> updateProfile({
    required String fullname,
    File? imageFile,
    Uint8List? webImageBytes,
  }) async {
    try {
      final token = await StorageHelper.getToken();
      final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.profile}");

      var request = http.MultipartRequest('PATCH', uri);

      final cleaned = token?.trim() ?? "";
      if (cleaned.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $cleaned';
      }

      request.fields['fullname'] = fullname;

      if (!kIsWeb && imageFile != null) {
        final image = await http.MultipartFile.fromPath('image', imageFile.path);
        request.files.add(image);
      } else if (kIsWeb && webImageBytes != null) {
        final image = http.MultipartFile.fromBytes(
          'image',
          webImageBytes,
          filename: 'profile_image.jpg',
        );
        request.files.add(image);
      }

      developer.log('📤 Updating profile...', name: 'ProfileService');

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      developer.log('📥 Update Response Status: ${response.statusCode}', name: 'ProfileService');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = ApiService.processResponse(response);
        final profile = ProfileModel.fromJson(data);

        return {
          'success': true,
          'message': 'Profile updated successfully',
          'profile': profile,
        };
      }

      else {
        throw Exception("Update failed: ${response.body}");
      }
    } catch (e) {
      developer.log('❌ Update Profile Error: $e', name: 'ProfileService');
      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }

  /// Delete account
  static Future<Map<String, dynamic>> deleteAccount() async {
    try {
      final token = await StorageHelper.getToken();
      final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.deleteAccount}");

      final response = await http.delete(
        uri,
        headers: {
          'Authorization': 'Bearer ${token?.trim() ?? ""}',
        },
      );

      developer.log('📥 Delete Account Response: ${response.statusCode}', name: 'ProfileService');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          'success': true,
          'message': 'Account deleted successfully',
        };
      } else {
        throw Exception("Delete failed: ${response.body}");
      }
    } catch (e) {
      developer.log('❌ Delete Account Error: $e', name: 'ProfileService');
      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }
}