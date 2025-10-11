import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/profile_model.dart';
import '../data/services/profile_service.dart';
import '../app/utils/storage_helper.dart';

class ProfileController extends GetxController {
  final isLoading = false.obs;
  final profile = Rxn<ProfileModel>();
  final voteCount = 0.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
    loadVoteCount();
  }

  /// Load user profile
  Future<void> loadProfile() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await ProfileService.fetchProfile();

      if (result['success'] == true) {
        profile.value = result['profile'] as ProfileModel;
        developer.log('✅ Profile loaded: ${profile.value?.username}', name: 'ProfileController');
      } else {
        errorMessage.value = result['message'] ?? 'Failed to load profile';
        Get.snackbar(
          'Error',
          errorMessage.value,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      developer.log('❌ Load Profile Error: $e', name: 'ProfileController');
      errorMessage.value = 'An error occurred';
    } finally {
      isLoading.value = false;
    }
  }

  /// Load vote count
  Future<void> loadVoteCount() async {
    try {
      final result = await ProfileService.fetchVoteCount();

      if (result['success'] == true) {
        final voteCountModel = result['voteCount'] as VoteCountModel;
        voteCount.value = voteCountModel.userVoteCount;
        developer.log('✅ Vote count loaded: ${voteCount.value}', name: 'ProfileController');
      }
    } catch (e) {
      developer.log('❌ Load Vote Count Error: $e', name: 'ProfileController');
    }
  }

  /// Delete account
  Future<void> deleteAccount(BuildContext context) async {
    // Show confirmation dialog
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: const Color(0xFF1C1C1E),
        title: const Text(
          'Delete Account',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    isLoading.value = true;

    try {
      final result = await ProfileService.deleteAccount();

      if (result['success'] == true) {
        Get.snackbar(
          'Success',
          'Account deleted successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        // Clear token and navigate to sign in
        await StorageHelper.clearToken();
        await Future.delayed(const Duration(seconds: 1));

        if (context.mounted) {
          Get.offAllNamed('/signIn');
        }
      } else {
        Get.snackbar(
          'Error',
          result['message'] ?? 'Failed to delete account',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      developer.log('❌ Delete Account Error: $e', name: 'ProfileController');
      Get.snackbar(
        'Error',
        'An error occurred',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Logout
  Future<void> logout(BuildContext context) async {
    await StorageHelper.clearToken();
    Get.offAllNamed('/signIn');
  }

  /// Refresh profile
  Future<void> refreshProfile() async {
    await loadProfile();
    await loadVoteCount();
  }
}