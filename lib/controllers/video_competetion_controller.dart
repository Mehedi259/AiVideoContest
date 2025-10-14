import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import '../data/models/video_competetion_model.dart';
import '../data/services/video_competetion_service.dart';

class VideoCompetitionController extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  List<ThemeModel> _themes = [];
  ThemeModel? _activeTheme;

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<ThemeModel> get themes => _themes;
  ThemeModel? get activeTheme => _activeTheme;

  /// Fetch all themes
  Future<void> fetchThemes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _themes = await VideoCompetitionService.fetchThemes();
      developer.log('✅ Fetched ${_themes.length} themes', name: 'VideoCompetitionController');
    } catch (e) {
      _error = e.toString();
      developer.log('❌ Error: $_error', name: 'VideoCompetitionController');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Fetch only the active theme
  Future<void> fetchActiveTheme() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _activeTheme = await VideoCompetitionService.fetchActiveTheme();
      if (_activeTheme != null) {
        developer.log('✅ Fetched active theme: ${_activeTheme!.themeName}',
            name: 'VideoCompetitionController');
      } else {
        developer.log('⚠️ No active theme found', name: 'VideoCompetitionController');
      }
    } catch (e) {
      _error = e.toString();
      developer.log('❌ Error: $_error', name: 'VideoCompetitionController');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}