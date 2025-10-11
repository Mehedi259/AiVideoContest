import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/badges_model.dart';
import '../data/services/badges_service.dart';

class BadgeController extends GetxController {
  final isLoading = false.obs;
  final badges = <BadgeModel>[].obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadBadges();
  }

  /// Load badges
  Future<void> loadBadges() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await BadgeService.fetchBadges();

      if (result['success'] == true) {
        badges.value = result['badges'] as List<BadgeModel>;
        developer.log('✅ Loaded ${badges.length} badges', name: 'BadgeController');
      } else {
        errorMessage.value = result['message'] ?? 'Failed to load badges';
        Get.snackbar(
          'Error',
          errorMessage.value,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      developer.log('❌ Load Badges Error: $e', name: 'BadgeController');
      errorMessage.value = 'An error occurred';
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh badges
  Future<void> refreshBadges() async {
    await loadBadges();
  }

  /// Download badge (opens URL)
  void downloadBadge(String downloadUrl) {
    // You can use url_launcher package to open the download URL
    Get.snackbar(
      'Download',
      'Opening download link...',
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );


    developer.log('Download URL: $downloadUrl', name: 'BadgeController');
  }
}