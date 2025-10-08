import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../data/models/uplod_video_models.dart';
import '../data/services/uplod_video_service.dart';


class UploadVideoController extends GetxController {
  final titleController = TextEditingController();
  final themeController = TextEditingController();

  final isLoading = false.obs;
  final isUploading = false.obs;
  final activeTheme = Rxn<ActiveThemeModel>();
  final errorMessage = ''.obs;

  File? videoFile;
  File? thumbnailFile;
  Uint8List? webVideoBytes;
  Uint8List? webThumbnailBytes;

  final hasVideoSelected = false.obs;
  final hasThumbnailSelected = false.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    loadActiveTheme();
  }

  @override
  void onClose() {
    titleController.dispose();
    themeController.dispose();
    super.onClose();
  }

  /// Load active theme
  Future<void> loadActiveTheme() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await UploadVideoService.fetchActiveTheme();

      if (result['success'] == true) {
        activeTheme.value = result['theme'] as ActiveThemeModel;
        themeController.text = activeTheme.value?.themeName ?? '';
        developer.log('✅ Active theme loaded: ${activeTheme.value?.themeName}', name: 'UploadVideoController');
      } else {
        errorMessage.value = result['message'] ?? 'Failed to load theme';
      }
    } catch (e) {
      developer.log('❌ Load Theme Error: $e', name: 'UploadVideoController');
      errorMessage.value = 'An error occurred';
    } finally {
      isLoading.value = false;
    }
  }

  /// Pick video from gallery
  Future<void> pickVideo() async {
    try {
      final XFile? pickedFile = await _picker.pickVideo(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        if (kIsWeb) {
          webVideoBytes = await pickedFile.readAsBytes();
        } else {
          videoFile = File(pickedFile.path);
        }
        hasVideoSelected.value = true;
        Get.snackbar(
          'Success',
          'Video selected',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 1),
        );
      }
    } catch (e) {
      developer.log('❌ Pick Video Error: $e', name: 'UploadVideoController');
      Get.snackbar(
        'Error',
        'Failed to pick video',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Pick thumbnail from gallery
  Future<void> pickThumbnail() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        if (kIsWeb) {
          webThumbnailBytes = await pickedFile.readAsBytes();
        } else {
          thumbnailFile = File(pickedFile.path);
        }
        hasThumbnailSelected.value = true;
        Get.snackbar(
          'Success',
          'Thumbnail selected',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 1),
        );
      }
    } catch (e) {
      developer.log('❌ Pick Thumbnail Error: $e', name: 'UploadVideoController');
      Get.snackbar(
        'Error',
        'Failed to pick thumbnail',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Validate and upload video
  Future<void> uploadVideo() async {
    if (titleController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter a title',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!hasVideoSelected.value) {
      Get.snackbar(
        'Validation Error',
        'Please select a video',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!hasThumbnailSelected.value) {
      Get.snackbar(
        'Validation Error',
        'Please select a thumbnail',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isUploading.value = true;

    try {
      final result = await UploadVideoService.uploadVideo(
        title: titleController.text.trim(),
        themeName: themeController.text.trim(),
        videoFile: videoFile,
        thumbnailFile: thumbnailFile,
        webVideoBytes: webVideoBytes,
        webThumbnailBytes: webThumbnailBytes,
      );

      if (result['success'] == true) {
        Get.snackbar(
          'Success',
          'Video uploaded successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        // Reset form
        titleController.clear();
        videoFile = null;
        thumbnailFile = null;
        webVideoBytes = null;
        webThumbnailBytes = null;
        hasVideoSelected.value = false;
        hasThumbnailSelected.value = false;
      } else {
        Get.snackbar(
          'Error',
          result['message'] ?? 'Upload failed',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      developer.log('❌ Upload Error: $e', name: 'UploadVideoController');
      Get.snackbar(
        'Error',
        'An error occurred during upload',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isUploading.value = false;
    }
  }
}