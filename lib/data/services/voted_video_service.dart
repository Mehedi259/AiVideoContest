import 'dart:developer' as developer;
import '../../app/constants/api_constants.dart';
import '../models/voted_video_model.dart';
import 'api_service.dart';

class VotedVideoService {
  /// Fetch voted videos
  static Future<Map<String, dynamic>> fetchVotedVideos() async {
    try {
      final response = await ApiService.getRequest(ApiConstants.votes);
      developer.log('📦 Voted Videos Response: $response', name: 'VotedVideoService');

      final List<dynamic> votesJson = response['votes'] ?? [];
      final List<VotedVideoModel> votedVideos = votesJson
          .map((json) => VotedVideoModel.fromJson(json))
          .toList();

      return {
        'success': true,
        'videos': votedVideos,
      };
    } catch (e) {
      developer.log('❌ Fetch Voted Videos Error: $e', name: 'VotedVideoService');
      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }
}