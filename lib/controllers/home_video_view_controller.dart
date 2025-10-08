import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../data/models/home_video_view_models.dart';
import '../data/services/home_video_view_service.dart';

class HomeVideoViewController extends GetxController {
  final int videoId;

  HomeVideoViewController(this.videoId);

  final isLoading = false.obs;
  final isVideoReady = false.obs;
  final isLiked = false.obs;
  final isDisliked = false.obs;
  final isVoted = false.obs;
  final video = Rxn<VideoDetailModel>();
  final errorMessage = ''.obs;

  VideoPlayerController? videoController;
  ChewieController? chewieController;

  @override
  void onInit() {
    super.onInit();
    loadVideoDetail();
    recordView();
  }

  @override
  void onClose() {
    videoController?.dispose();
    chewieController?.dispose();
    super.onClose();
  }

  /// Load video details
  Future<void> loadVideoDetail() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await HomeVideoViewService.fetchVideoDetail(videoId);

      if (result['success'] == true) {
        video.value = result['video'] as VideoDetailModel;
        developer.log('✅ Video loaded: ${video.value?.title}', name: 'HomeVideoViewController');

        // Initialize video player
        await _initializeVideoPlayer();
      } else {
        errorMessage.value = result['message'] ?? 'Failed to load video';
        Get.snackbar(
          'Error',
          errorMessage.value,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      developer.log('❌ Load Video Error: $e', name: 'HomeVideoViewController');
      errorMessage.value = 'An error occurred';
    } finally {
      isLoading.value = false;
    }
  }

  /// Initialize video player
  Future<void> _initializeVideoPlayer() async {
    if (video.value == null) return;

    videoController = VideoPlayerController.networkUrl(
      Uri.parse(video.value!.videoFile),
    );

    await videoController!.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoController!,
      autoPlay: true,
      looping: false,
      allowFullScreen: true,
      allowMuting: false,
      allowPlaybackSpeedChanging: false,
      aspectRatio: videoController!.value.aspectRatio,
    );

    isVideoReady.value = true;
  }

  /// Record video view
  Future<void> recordView() async {
    await HomeVideoViewService.performAction(videoId, 'views');
  }

  /// Like video
  Future<void> likeVideo() async {
    if (isLiked.value) return;

    final result = await HomeVideoViewService.performAction(videoId, 'like');

    if (result['success'] == true) {
      isLiked.value = true;
      isDisliked.value = false;

      Get.snackbar(
        'Success',
        'Video liked',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
      );
    }
  }

  /// Dislike video
  Future<void> dislikeVideo() async {
    if (isDisliked.value) return;

    final result = await HomeVideoViewService.performAction(videoId, 'dislike');

    if (result['success'] == true) {
      isDisliked.value = true;
      isLiked.value = false;

      Get.snackbar(
        'Success',
        'Video disliked',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
      );
    }
  }

  /// Vote for video
  Future<void> voteVideo() async {
    if (isVoted.value) return;

    final result = await HomeVideoViewService.performAction(videoId, 'vote');

    if (result['success'] == true) {
      isVoted.value = true;

      Get.snackbar(
        'Success',
        'Vote recorded successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  /// Report video
  Future<void> reportVideo() async {
    final result = await HomeVideoViewService.performAction(videoId, 'report');

    if (result['success'] == true) {
      Get.snackbar(
        'Success',
        'Video reported',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }
}