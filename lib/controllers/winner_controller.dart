import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/winner_models.dart';
import '../data/services/winner_service.dart';

class WinnerController extends GetxController {
  final isLoading = false.obs;
  final winner = Rxn<WinnerVideoModel>();
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadWinner();
  }

  /// Load winner video
  Future<void> loadWinner() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await WinnerService.fetchWinnerVideo();

      if (result['success'] == true) {
        winner.value = result['winner'] as WinnerVideoModel;
        developer.log('✅ Winner video loaded: ${winner.value?.title}', name: 'WinnerController');
      } else {
        errorMessage.value = result['message'] ?? 'Failed to load winner video';
        Get.snackbar(
          'Error',
          errorMessage.value,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      developer.log('❌ Load Winner Error: $e', name: 'WinnerController');
      errorMessage.value = 'An error occurred';
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh winner video
  Future<void> refreshWinner() async {
    await loadWinner();
  }
}