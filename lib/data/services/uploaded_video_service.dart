import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import '../../app/constants/api_constants.dart';
import '../../app/utils/storage_helper.dart';
import '../models/profile_model.dart';


class UploadedVideoService {
  /// Fetch uploaded videos (from profile)
  static Future<Map<String, dynamic>> fetchUploadedVideos() async {
    try {
      final token = await StorageHelper.getToken();
      if (token == null || token.isEmpty) {
        throw Exception("No token found");
      }

      final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.profile}");
      developer.log('📤 GET Request to: $uri', name: 'UploadedVideoService');

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer ${token.trim()}',
          'Content-Type': 'application/json',
        },
      );

      developer.log('📥 Response Status: ${response.statusCode}', name: 'UploadedVideoService');
      developer.log('📥 Response Body: ${response.body}', name: 'UploadedVideoService');

      if (response.statusCode == 200) {
        final profile = ProfileModel.fromJson(jsonDecode(response.body));
        return {
          'success': true,
          'videos': profile.uploadedVideos,
        };
      } else {
        final decoded = response.body.isNotEmpty ? jsonDecode(response.body) : {};
        return {
          'success': false,
          'message': decoded['message'] ?? 'Failed to fetch videos',
        };
      }
    } catch (e) {
      developer.log('❌ Fetch Uploaded Videos Error: $e', name: 'UploadedVideoService');
      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }

  /// Delete video
  static Future<Map<String, dynamic>> deleteVideo(int videoId) async {
    try {
      final token = await StorageHelper.getToken();
      if (token == null || token.isEmpty) {
        throw Exception("No token found");
      }

      final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.deleteVideo(videoId)}");
      developer.log('📤 DELETE Request to: $uri', name: 'UploadedVideoService');
      developer.log('🔑 Token: Bearer ${token.trim()}', name: 'UploadedVideoService');

      final response = await http.delete(
        uri,
        headers: {
          'Authorization': 'Bearer ${token.trim()}',
          'Content-Type': 'application/json',
        },
      );

      developer.log('📥 Delete Response Status: ${response.statusCode}', name: 'UploadedVideoService');
      developer.log('📥 Delete Response Body: ${response.body}', name: 'UploadedVideoService');

      if (response.statusCode == 200 || response.statusCode == 204) {
        return {'success': true, 'message': 'Video deleted successfully'};
      } else {
        final decoded = response.body.isNotEmpty ? jsonDecode(response.body) : {};
        return {
          'success': false,
          'message': decoded['message'] ?? 'Failed to delete video',
        };
      }
    } catch (e) {
      developer.log('❌ Delete Video Error: $e', name: 'UploadedVideoService');
      return {'success': false, 'message': e.toString().replaceAll('Exception: ', '')};
    }
  }
}
