import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:Prommt/gen/assets.gen.dart';
import '../../../app/routes/app_routes.dart';
import '../../../controllers/uploaded_video_controller.dart';
import '../../widgets/navigation_bar.dart';
import '../../widgets/liked_video_card.dart';

class UploadedVideoScreen extends StatefulWidget {
  const UploadedVideoScreen({super.key});

  @override
  State<UploadedVideoScreen> createState() => _UploadedVideoScreenState();
}

class _UploadedVideoScreenState extends State<UploadedVideoScreen> {
  late UploadedVideoController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(UploadedVideoController());
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
          "Uploaded Video",
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

        if (controller.uploadedVideos.isEmpty) {
          return const Center(
            child: Text(
              'No uploaded videos yet',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshUploadedVideos,
          color: const Color(0xFF004AAD),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: controller.uploadedVideos.length,
            itemBuilder: (context, index) {
              final video = controller.uploadedVideos[index];
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
                    user: video.user!.username,
                    views: "${video.views} views",
                    onTap: () {
                      context.go('${Routes.videoPlay}?id=${video.id}');
                    },
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          icon: Assets.icons.delete.image(width: 20, height: 20),
                          label: "Delete",
                          labelColor: Colors.red,
                          onTap: () => controller.deleteVideo(video.id),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildActionButton(
                          icon: Assets.icons.bxShare.image(width: 20, height: 20),
                          label: "Share",
                          labelColor: Colors.white,
                          onTap: () => _showSharePopup(context, video.id),
                        ),
                      ),
                    ],
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

  Widget _buildActionButton({
    required Widget icon,
    required String label,
    required Color labelColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade700, width: 1),
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: labelColor,
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _showSharePopup(BuildContext context, int videoId) {
    final shareUrl = "http://10.10.7.86:8000/video/$videoId";

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0xFFB0B3BB),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Share link",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color(0xFF1C1C1E),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF141415),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        shareUrl,
                        style: const TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: shareUrl));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Link copied to clipboard"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1C1E),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Copy",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xFFFDFDFD),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}