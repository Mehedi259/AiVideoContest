import 'dart:developer' as developer;
import '../../app/constants/api_constants.dart';
import '../models/liked_video_models.dart';
import 'api_service.dart';

class LikedVideoService {
  /// Fetch all liked videos
  static Future<Map<String, dynamic>> fetchLikedVideos() async {
    try {
      final response = await ApiService.getRequest(
        ApiConstants.likedVideos,
      );

      developer.log('📦 Liked Videos Response: $response', name: 'LikedVideoService');

      final List<dynamic> likedVideosJson = response['liked_videos'] ?? [];
      final List<LikedVideoModel> likedVideos = likedVideosJson
          .map((json) => LikedVideoModel.fromJson(json))
          .toList();

      return {
        'success': true,
        'videos': likedVideos,
      };
    } catch (e) {
      developer.log('❌ Fetch Liked Videos Error: $e', name: 'LikedVideoService');
      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }
}