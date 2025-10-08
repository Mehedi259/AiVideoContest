import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/liked_video_models.dart';
import '../data/services/liked_video_service.dart';

class LikedVideoController extends GetxController {
  final isLoading = false.obs;
  final likedVideos = <LikedVideoModel>[].obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadLikedVideos();
  }

  /// Load all liked videos
  Future<void> loadLikedVideos() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await LikedVideoService.fetchLikedVideos();

      if (result['success'] == true) {
        likedVideos.value = result['videos'] as List<LikedVideoModel>;
        developer.log('✅ Loaded ${likedVideos.length} liked videos', name: 'LikedVideoController');
      } else {
        errorMessage.value = result['message'] ?? 'Failed to load liked videos';
        Get.snackbar(
          'Error',
          errorMessage.value,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      developer.log('❌ Load Liked Videos Error: $e', name: 'LikedVideoController');
      errorMessage.value = 'An error occurred';
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh liked videos
  Future<void> refreshLikedVideos() async {
    await loadLikedVideos();
  }
}