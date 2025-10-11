import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/voted_video_model.dart';
import '../data/services/voted_video_service.dart';

class VotedVideoController extends GetxController {
  final isLoading = false.obs;
  final votedVideos = <VotedVideoModel>[].obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadVotedVideos();
  }

  /// Load voted videos
  Future<void> loadVotedVideos() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await VotedVideoService.fetchVotedVideos();

      if (result['success'] == true) {
        votedVideos.value = result['videos'] as List<VotedVideoModel>;
        developer.log('✅ Loaded ${votedVideos.length} voted videos', name: 'VotedVideoController');
      } else {
        errorMessage.value = result['message'] ?? 'Failed to load voted videos';
        Get.snackbar(
          'Error',
          errorMessage.value,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      developer.log('❌ Load Voted Videos Error: $e', name: 'VotedVideoController');
      errorMessage.value = 'An error occurred';
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh voted videos
  Future<void> refreshVotedVideos() async {
    await loadVotedVideos();
  }
}