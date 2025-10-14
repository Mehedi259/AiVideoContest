import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:chewie/chewie.dart';
import '../../../app/routes/app_routes.dart';
import '../../../controllers/home_video_view_controller.dart';
import '../../../gen/assets.gen.dart';
import '../../widgets/navigation_bar.dart';

class VideoDetailScreen extends StatefulWidget {
  final int videoId;

  const VideoDetailScreen({super.key, required this.videoId});

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  late HomeVideoViewController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(HomeVideoViewController(widget.videoId));
  }

  @override
  void dispose() {
    Get.delete<HomeVideoViewController>();
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF004AAD)),
            );
          }

          if (controller.video.value == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Failed to load video',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.go(Routes.home),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.go(Routes.home),
                        child: Assets.icons.backButton.image(width: 30,
                            height: 30),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Center(
                          child: Text(
                            controller.video.value!.title,
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 46),
                    ],
                  ),
                ),

                // Content with 20px margin
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      // Video Player
                      Obx(() {
                        if (!controller.isVideoReady.value) {
                          return AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Container(
                              color: Colors.grey[900],
                              child: const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              ),
                            ),
                          );
                        }

                        return AspectRatio(
                          aspectRatio: controller.videoController!.value
                              .aspectRatio,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Chewie(
                                controller: controller.chewieController!),
                          ),
                        );
                      }),

                      const SizedBox(height: 20),

                      // Video Info and Actions
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.video.value!.title,
                                  style: const TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '@${controller.video.value!.user.username}',
                                  style: const TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Color(0xFFB0B3B8),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Action Buttons
                          Obx(() =>
                              Row(
                                children: [
                                  // Like Button
                                  GestureDetector(
                                    onTap: () => controller.likeVideo(),
                                    child: Column(
                                      children: [
                                        controller.isLiked.value
                                            ? Assets.icons.like.image(
                                            width: 24, height: 24)
                                            : Assets.icons.likeWhite.image(
                                            width: 24, height: 24),
                                        const SizedBox(height: 2),
                                        const Text(
                                          "Like",
                                          style: TextStyle(color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),

                                  // Dislike Button
                                  GestureDetector(
                                    onTap: () => controller.dislikeVideo(),
                                    child: Column(
                                      children: [
                                        controller.isDisliked.value
                                            ? Assets.icons.dislikeBlue.image(
                                            width: 24, height: 24)
                                            : Assets.icons.dislike.image(
                                            width: 24, height: 24),
                                        const SizedBox(height: 2),
                                        const Text(
                                          "Dislike",
                                          style: TextStyle(color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),

                                  // Report Button
                                  GestureDetector(
                                    onTap: () => controller.reportVideo(),
                                    child: Column(
                                      children: [
                                        Assets.icons.flag.image(
                                            width: 24, height: 24),
                                        const SizedBox(height: 2),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(
                                                4),
                                          ),
                                          child: const Text(
                                            "Report",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // Vote Button
                      Center(
                        child: Obx(() =>
                            GestureDetector(
                              onTap: controller.isVoted.value
                                  ? null
                                  : () => controller.voteVideo(),
                              child: Container(
                                width: 167,
                                height: 134,
                                decoration: BoxDecoration(
                                  color: controller.isVoted.value
                                      ? Colors.grey
                                      : const Color(0xFF004AAD),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Assets.images.vote.image(
                                        width: 60, height: 60),
                                    const SizedBox(height: 8),
                                    Text(
                                      controller.isVoted.value
                                          ? "Voted"
                                          : "Vote",
                                      style: const TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              GoRouter.of(context).go(Routes.home);
              break;
            case 1:
              GoRouter.of(context).go(Routes.likedVideos);
              break;
            case 2:
              GoRouter.of(context).go(Routes.uploadVideos);
              break;
            case 3:
              GoRouter.of(context).go(Routes.winner);
              break;
            case 4:
              GoRouter.of(context).go(Routes.profile);
              break;
          }
        },
      ),
    );
  }
}