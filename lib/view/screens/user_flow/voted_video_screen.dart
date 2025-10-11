import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:Prommt/gen/assets.gen.dart';
import '../../../app/routes/app_routes.dart';
import '../../../controllers/voted_video_controller.dart';
import '../../widgets/navigation_bar.dart';
import '../../widgets/liked_video_card.dart';

class VotedVideoScreen extends StatefulWidget {
  const VotedVideoScreen({super.key});

  @override
  State<VotedVideoScreen> createState() => _VotedVideoScreenState();
}

class _VotedVideoScreenState extends State<VotedVideoScreen> {
  late VotedVideoController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(VotedVideoController());
  }

  @override
  Widget build(BuildContext context) {
    final baseUrl = "http://10.10.7.86:8000";

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Assets.icons.arrowLeft.image(width: 22, height: 22),
          onPressed: () => context.go(Routes.profile),
        ),
        title: const Text(
          "Voted Video",
          style: TextStyle(
            fontFamily: "Raleway",
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF004AAD)),
          );
        }

        if (controller.votedVideos.isEmpty) {
          return const Center(
            child: Text(
              'No voted videos yet',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshVotedVideos,
          color: const Color(0xFF004AAD),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: controller.votedVideos.length,
            itemBuilder: (context, index) {
              final votedVideo = controller.votedVideos[index];
              final video = votedVideo.video;
              final thumbnailUrl = video.thumbnail.startsWith('http')
                  ? video.thumbnail
                  : '$baseUrl${video.thumbnail}';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index == 0)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        video.themeName,
                        style: const TextStyle(
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Color(0xFF004AAD),
                        ),
                      ),
                    ),

                  LikedVideoCard(
                    imagePath: thumbnailUrl,
                    title: video.title,
                    user: video.user.username,
                    views: "${video.views} views",
                    onTap: () {
                      context.go('${Routes.videoPlay}?id=${video.id}');
                    },
                  ),

                  const SizedBox(height: 24),
                ],
              );
            },
          ),
        );
      }),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: 4,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go(Routes.home);
              break;
            case 1:
              context.go(Routes.likedVideos);
              break;
            case 2:
              context.go(Routes.uploadVideos);
              break;
            case 3:
              context.go(Routes.winner);
              break;
            case 4:
              context.go(Routes.profile);
              break;
          }
        },
      ),
    );
  }
}