import 'dart:developer' as developer;
import '../models/video_competetion_model.dart';
import '../../app/constants/api_constants.dart';
import './api_service.dart';

class VideoCompetitionService {
  /// Fetch all themes
  static Future<List<ThemeModel>> fetchThemes() async {
    try {
      developer.log('🎯 Fetching themes...', name: 'VideoCompetitionService');

      final response = await ApiService.getRequest(ApiConstants.themes);

      if (response is List) {
        return response.map((json) => ThemeModel.fromJson(json)).toList();
      }

      throw Exception('Invalid response format');
    } catch (e) {
      developer.log('❌ Error fetching themes: $e', name: 'VideoCompetitionService');
      rethrow;
    }
  }

  /// Fetch active theme only
  static Future<ThemeModel?> fetchActiveTheme() async {
    try {
      developer.log('🎯 Fetching active theme...', name: 'VideoCompetitionService');

      final themes = await fetchThemes();

      // Find the active theme
      for (var theme in themes) {
        if (theme.isActive) {
          return theme;
        }
      }

      return null; // No active theme found
    } catch (e) {
      developer.log('❌ Error fetching active theme: $e', name: 'VideoCompetitionService');
      rethrow;
    }
  }
}