import 'dart:developer' as developer;
import '../../app/constants/api_constants.dart';
import '../models/home_models.dart';
import 'api_service.dart';

class HomeService {
  /// Fetch active theme
  static Future<Map<String, dynamic>> fetchActiveTheme() async {
    try {
      final response = await ApiService.getRequest(ApiConstants.themes);
      developer.log('📦 Themes Response: $response', name: 'HomeService');

      if (response is List && response.isNotEmpty) {
        // Find the active theme
        final activeTheme = response.firstWhere(
              (theme) => theme['is_active'] == true,
          orElse: () => response.first,
        );

        return {
          'success': true,
          'theme_name': activeTheme['theme_name'] ?? '',
          'theme_cover_image': activeTheme['theme_cover_image_url'] ?? '',
        };
      }

      return {
        'success': false,
        'message': 'No themes available',
      };
    } catch (e) {
      developer.log('❌ Fetch Active Theme Error: $e', name: 'HomeService');
      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }

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