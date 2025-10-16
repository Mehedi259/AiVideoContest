import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
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

        if (badges.isEmpty) {
          developer.log('⚠️ No badges found in response', name: 'BadgeController');
        }
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
      errorMessage.value = 'An error occurred: $e';
      Get.snackbar(
        'Error',
        'Failed to load badges',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh badges
  Future<void> refreshBadges() async {
    await loadBadges();
  }

  /// Download badge using url_launcher
  Future<void> downloadBadge(String downloadUrl) async {
    try {
      developer.log('📥 Attempting to download: $downloadUrl', name: 'BadgeController');

      final Uri url = Uri.parse(downloadUrl);

      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
        Get.snackbar(
          'Download',
          'Opening download...',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      } else {
        throw Exception('Could not launch $downloadUrl');
      }
    } catch (e) {
      developer.log('❌ Download Error: $e', name: 'BadgeController');
      Get.snackbar(
        'Error',
        'Failed to open download link',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}