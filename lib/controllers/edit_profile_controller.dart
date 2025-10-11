import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../data/models/profile_model.dart';
import '../data/services/profile_service.dart';

class EditProfileController extends GetxController {
  final fullnameController = TextEditingController();

  final isLoading = false.obs;
  final isUpdating = false.obs;
  final profile = Rxn<ProfileModel>();
  final hasImageSelected = false.obs;

  File? imageFile;
  Uint8List? webImageBytes;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  @override
  void onClose() {
    fullnameController.dispose();
    super.onClose();
  }

  /// Load profile
  Future<void> loadProfile() async {
    isLoading.value = true;

    try {
      final result = await ProfileService.fetchProfile();

      if (result['success'] == true) {
        profile.value = result['profile'] as ProfileModel;
        fullnameController.text = profile.value?.fullname ?? '';
        developer.log('✅ Profile loaded for editing', name: 'EditProfileController');
      }
    } catch (e) {
      developer.log('❌ Load Profile Error: $e', name: 'EditProfileController');
    } finally {
      isLoading.value = false;
    }
  }

  /// Pick profile image
  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        if (kIsWeb) {
          webImageBytes = await pickedFile.readAsBytes();
        } else {
          imageFile = File(pickedFile.path);
        }
        hasImageSelected.value = true;
        Get.snackbar(
          'Success',
          'Image selected',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 1),
        );
      }
    } catch (e) {
      developer.log('❌ Pick Image Error: $e', name: 'EditProfileController');
      Get.snackbar(
        'Error',
        'Failed to pick image',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Update profile
  Future<void> updateProfile() async {
    if (fullnameController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter your full name',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isUpdating.value = true;

    try {
      final result = await ProfileService.updateProfile(
        fullname: fullnameController.text.trim(),
        imageFile: imageFile,
        webImageBytes: webImageBytes,
      );

      if (result['success'] == true) {
        Get.snackbar(
          'Success',
          'Profile updated successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        // Update profile data
        profile.value = result['profile'] as ProfileModel;

        // Reset image selection
        imageFile = null;
        webImageBytes = null;
        hasImageSelected.value = false;

        // Navigate back after short delay
        await Future.delayed(const Duration(milliseconds: 500));
        Get.back();
      } else {
        Get.snackbar(
          'Error',
          result['message'] ?? 'Update failed',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      developer.log('❌ Update Profile Error: $e', name: 'EditProfileController');
      Get.snackbar(
        'Error',
        'An error occurred during update',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isUpdating.value = false;
    }
  }
}