import 'dart:developer' as developer;
import '../../app/constants/api_constants.dart';
import '../models/badges_model.dart';
import 'api_service.dart';

class BadgeService {
  /// Fetch badges/winners
  static Future<Map<String, dynamic>> fetchBadges() async {
    try {
      final response = await ApiService.getRequest(ApiConstants.winners);
      developer.log('📦 Badges Response: $response', name: 'BadgeService');

      final List<dynamic> badgesJson = response is List ? response : [];
      final List<BadgeModel> badges = badgesJson
          .map((json) => BadgeModel.fromJson(json))
          .toList();

      return {
        'success': true,
        'badges': badges,
      };
    } catch (e) {
      developer.log('❌ Fetch Badges Error: $e', name: 'BadgeService');
      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }
}