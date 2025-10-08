import 'dart:developer' as developer;
import '../../app/constants/api_constants.dart';
import '../models/home_video_view_models.dart';
import 'api_service.dart';

class HomeVideoViewService {
  /// Fetch video details
  static Future<Map<String, dynamic>> fetchVideoDetail(int videoId) async {
    try {
      final response = await ApiService.getRequest(
        ApiConstants.videoDetail(videoId),
      );
      developer.log('📦 Video Detail Response: $response', name: 'HomeVideoViewService');

      final video = VideoDetailModel.fromJson(response);
      return {
        'success': true,
        'video': video,
      };
    } catch (e) {
      developer.log('❌ Fetch Video Detail Error: $e', name: 'HomeVideoViewService');
      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }

  /// Perform video action (like, dislike, vote, report, views)
  static Future<Map<String, dynamic>> performAction(
      int videoId,
      String action,
      ) async {
    try {
      final response = await ApiService.postRequest(
        ApiConstants.videoAction(videoId),
        body: {"action": action},
      );

      developer.log('✅ Action "$action" performed: $response', name: 'HomeVideoViewService');

      return {
        'success': true,
        'message': response['success'] ?? 'Action completed',
      };
    } catch (e) {
      developer.log('❌ Perform Action Error: $e', name: 'HomeVideoViewService');
      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }
}