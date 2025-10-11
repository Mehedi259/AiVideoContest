import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/profile_model.dart';
import '../data/services/uploaded_video_service.dart';

class UploadedVideoController extends GetxController {
  final isLoading = false.obs;
  final uploadedVideos = <UploadedVideoInfo>[].obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUploadedVideos();
  }

  /// Load uploaded videos
  Future<void> loadUploadedVideos() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await UploadedVideoService.fetchUploadedVideos();

      if (result['success'] == true) {
        uploadedVideos.value = result['videos'] as List<UploadedVideoInfo>;
        developer.log('✅ Loaded ${uploadedVideos.length} uploaded videos', name: 'UploadedVideoController');
      } else {
        errorMessage.value = result['message'] ?? 'Failed to load uploaded videos';
        Get.snackbar(
          'Error',
          errorMessage.value,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      developer.log('❌ Load Uploaded Videos Error: $e', name: 'UploadedVideoController');
      errorMessage.value = 'An error occurred';
      Get.snackbar(
        'Error',
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Delete video (Clean & Corrected)
  Future<void> deleteVideo(int videoId) async {
    // 1️⃣ Show confirmation dialog
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: const Color(0xFF1C1C1E),
        title: const Text('Delete Video', style: TextStyle(color: Colors.white)),
        content: const Text('Are you sure you want to delete this video?', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Get.back(result: false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      // 2️⃣ Call Service
      final result = await UploadedVideoService.deleteVideo(videoId);

      // 3️⃣ Handle response properly
      if (result['success'] == true) {
        Get.snackbar(
          'Success',
          result['message'] ?? 'Video deleted successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        // 4️⃣ Refresh the uploaded videos list
        await loadUploadedVideos();
      } else {
        Get.snackbar(
          'Error',
          result['message'] ?? 'Failed to delete video',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      developer.log('❌ Delete Video Error: $e', name: 'UploadedVideoController');
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Refresh uploaded videos
  Future<void> refreshUploadedVideos() async {
    await loadUploadedVideos();
  }
}
