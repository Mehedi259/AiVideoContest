import 'dart:developer' as developer;
import '../../app/constants/api_constants.dart';
import '../models/winner_models.dart';
import 'api_service.dart';

class WinnerService {
  /// Fetch winner video
  static Future<Map<String, dynamic>> fetchWinnerVideo() async {
    try {
      final response = await ApiService.getRequest(
        ApiConstants.winner,
      );

      developer.log('📦 Winner Video Response: $response', name: 'WinnerService');

      final winner = WinnerVideoModel.fromJson(response);
      return {
        'success': true,
        'winner': winner,
      };
    } catch (e) {
      developer.log('❌ Fetch Winner Video Error: $e', name: 'WinnerService');
      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }
}