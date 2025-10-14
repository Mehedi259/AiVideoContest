import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/home_models.dart';
import '../data/services/home_service.dart';

class HomeController extends GetxController {
  final isLoading = false.obs;
  final showTop3 = false.obs;
  final videos = <VideoModel>[].obs;
  final top3Videos = <VideoModel>[].obs;
  final errorMessage = ''.obs;

  // 👉 Reactive variables for theme
  final themeName = RxnString();
  final themeCoverImage = RxnString();

  @override
  void onInit() {
    super.onInit();
    loadActiveTheme();
    loadVideos();
    loadLeaderboard();
  }

  /// Load active theme from themes API
  Future<void> loadActiveTheme() async {
    try {
      final result = await HomeService.fetchActiveTheme();

      if (result['success'] == true) {
        themeName.value = result['theme_name'];
        themeCoverImage.value = result['theme_cover_image'];

        developer.log(
          '✅ Theme loaded: ${themeName.value}',
          name: 'HomeController',
        );
      } else {
        developer.log(
          '⚠️ No active theme found',
          name: 'HomeController',
        );
      }
    } catch (e) {
      developer.log('❌ Load Theme Error: $e', name: 'HomeController');
    }
  }

  /// Load all videos
  Future<void> loadVideos() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await HomeService.fetchVideos();

      if (result['success'] == true) {
        videos.value = result['videos'] as List<VideoModel>;
        developer.log('✅ Loaded ${videos.length} videos', name: 'HomeController');
      } else {
        errorMessage.value = result['message'] ?? 'Failed to load videos';
        Get.snackbar(
          'Error',
          errorMessage.value,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      developer.log('❌ Load Videos Error: $e', name: 'HomeController');
      errorMessage.value = 'An error occurred';
    } finally {
      isLoading.value = false;
    }
  }

  /// Load top 3 videos
  Future<void> loadLeaderboard() async {
    try {
      final result = await HomeService.fetchLeaderboard();

      if (result['success'] == true) {
        top3Videos.value = result['videos'] as List<VideoModel>;
        developer.log('✅ Loaded ${top3Videos.length} top videos', name: 'HomeController');
      }
    } catch (e) {
      developer.log('❌ Load Leaderboard Error: $e', name: 'HomeController');
    }
  }

  /// Toggle between all videos and top 3
  void toggleView() {
    showTop3.value = !showTop3.value;
  }

  /// Refresh all data
  Future<void> refreshAll() async {
    await Future.wait([
      loadActiveTheme(),
      loadVideos(),
      loadLeaderboard(),
    ]);
  }
}