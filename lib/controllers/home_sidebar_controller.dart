import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../app/routes/app_routes.dart';
import '../data/models/home_sidebar_models.dart';
import '../data/services/home_sidebar_service.dart';

class HomeSidebarController extends GetxController {
  final isLoading = false.obs;
  final profile = Rxn<ProfileModel>();
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  /// Load user profile
  Future<void> loadProfile() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await HomeSidebarService.fetchProfile();

      if (result['success'] == true) {
        profile.value = result['profile'] as ProfileModel;
        developer.log('✅ Profile loaded: ${profile.value?.username}', name: 'HomeSidebarController');
      } else {
        errorMessage.value = result['message'] ?? 'Failed to load profile';
      }
    } catch (e) {
      developer.log('❌ Load Profile Error: $e', name: 'HomeSidebarController');
      errorMessage.value = 'An error occurred';
    } finally {
      isLoading.value = false;
    }
  }

  /// Logout user
  Future<void> logout(BuildContext context) async {
    await HomeSidebarService.logout();

    Get.snackbar(
      'Success',
      'Logged out successfully',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );

    if (context.mounted) {
      context.go(Routes.welcome);
    }
  }
}