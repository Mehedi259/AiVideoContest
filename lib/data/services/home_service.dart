import 'dart:developer' as developer;
import '../../app/constants/api_constants.dart';
import '../models/home_models.dart';
import 'api_service.dart';

class HomeService {
  /// Fetch all videos
  static Future<Map<String, dynamic>> fetchVideos() async {
    try {
      final response = await ApiService.getRequest(ApiConstants.videos);
      developer.log('📦 Videos Response: $response', name: 'HomeService');

      if (response is List) {
        final videos = response.map((video) => VideoModel.fromJson(video)).toList();
        return {
          'success': true,
          'videos': videos,
        };
      }

      return {
        'success': false,
        'message': 'Invalid response format',
      };
    } catch (e) {
      developer.log('❌ Fetch Videos Error: $e', name: 'HomeService');
      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }

  /// Fetch leaderboard (Top 3)
  static Future<Map<String, dynamic>> fetchLeaderboard() async {
    try {
      final response = await ApiService.getRequest(ApiConstants.leaderboard);
      developer.log('📦 Leaderboard Response: $response', name: 'HomeService');

      if (response is List) {
        final videos = response.map((video) => VideoModel.fromJson(video)).toList();
        return {
          'success': true,
          'videos': videos,
        };
      }

      return {
        'success': false,
        'message': 'Invalid response format',
      };
    } catch (e) {
      developer.log('❌ Fetch Leaderboard Error: $e', name: 'HomeService');
      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }

  /// Record video view
  static Future<Map<String, dynamic>> recordView(int videoId) async {
    try {
      final response = await ApiService.postRequest(
        ApiConstants.videoAction(videoId),
        body: {"action": "views"},
      );

      developer.log('✅ View recorded: $response', name: 'HomeService');

      return {
        'success': true,
        'message': response['success'] ?? 'View recorded',
      };
    } catch (e) {
      developer.log('❌ Record View Error: $e', name: 'HomeService');
      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }
}