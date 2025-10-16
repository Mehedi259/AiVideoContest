import 'dart:developer' as developer;
import '../../app/constants/api_constants.dart';
import '../models/badges_model.dart';
import 'api_service.dart';

class BadgeService {
  /// Fetch badges/winners - Handles both single object and array responses
  static Future<Map<String, dynamic>> fetchBadges() async {
    try {
      developer.log('🔍 Fetching badges from: ${ApiConstants.baseUrl}${ApiConstants.winners}',
          name: 'BadgeService');

      final response = await ApiService.getRequest(ApiConstants.winners);

      developer.log('📦 Raw Response Type: ${response.runtimeType}', name: 'BadgeService');
      developer.log('📦 Raw Response: $response', name: 'BadgeService');

      List<BadgeModel> badges = [];

      // Check if response is a Map (single badge) or List (multiple badges)
      if (response is Map<String, dynamic>) {
        // Single badge response
        developer.log('✅ Response is a single badge object', name: 'BadgeService');

        // Add 'id' field if missing (API doesn't return it)
        final badgeData = Map<String, dynamic>.from(response);
        if (!badgeData.containsKey('id')) {
          badgeData['id'] = 1; // Default ID since API doesn't provide it
        }

        final badge = BadgeModel.fromJson(badgeData);
        badges.add(badge);

        developer.log('✅ Single badge parsed: username=${badge.username}, picture=${badge.picture}',
            name: 'BadgeService');
      }
      else if (response is List) {
        // Multiple badges response
        developer.log('✅ Response is a List with ${response.length} items', name: 'BadgeService');

        for (var i = 0; i < response.length; i++) {
          try {
            final json = response[i] as Map<String, dynamic>;

            // Add 'id' field if missing
            if (!json.containsKey('id')) {
              json['id'] = i + 1;
            }

            final badge = BadgeModel.fromJson(json);
            badges.add(badge);

            developer.log('✅ Badge $i parsed: username=${badge.username}',
                name: 'BadgeService');
          } catch (e) {
            developer.log('❌ Failed to parse badge $i: $e', name: 'BadgeService');
          }
        }
      }
      else {
        developer.log('❌ Unexpected response type: ${response.runtimeType}',
            name: 'BadgeService');
      }

      developer.log('✅ Total badges parsed successfully: ${badges.length}',
          name: 'BadgeService');

      return {
        'success': true,
        'badges': badges,
      };
    } catch (e, stackTrace) {
      developer.log('❌ Fetch Badges Error: $e', name: 'BadgeService');
      developer.log('Stack trace: $stackTrace', name: 'BadgeService');

      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }
}