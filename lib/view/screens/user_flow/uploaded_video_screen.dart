import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trope/gen/assets.gen.dart';

import '../../../app/routes/app_routes.dart';
import '../../widgets/navigation_bar.dart';
import '../../widgets/liked_video_card.dart';

class UploadedVideoScreen extends StatelessWidget {
  const UploadedVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      /// AppBar
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Assets.icons.arrowLeft.image(width: 22, height: 22),
          onPressed: () => GoRouter.of(context).go(Routes.profile),
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

      /// Body (Scrollable)
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Section Title
            const Text(
              "Halloween Theme",
              style: TextStyle(
                fontFamily: "Raleway",
                fontWeight: FontWeight.w700,
                fontSize: 18,
                height: 1.0,
                color: Color(0xFF004AAD),
              ),
            ),
            const SizedBox(height: 16),

            /// Video Card (Same style as LikedVideoCard)
            LikedVideoCard(
              imagePath: Assets.images.like1.path,
              title: "Dinner Event",
              user: "John Doe",
              views: "472 views",
              onTap: () {
                // TODO: navigate to video details
              },
            ),

            const SizedBox(height: 12),

            /// Action Buttons (Delete & Share) in one Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: Assets.icons.delete.image(width: 20, height: 20),
                    label: "Delete",
                    labelColor: Colors.red,
                    onTap: () {
                      // TODO: Delete action
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionButton(
                    icon: Assets.icons.bxShare.image(width: 20, height: 20),
                    label: "Share",
                    labelColor: Colors.white,
                    onTap: () {
                      // TODO: Share action
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      /// Bottom Navigation Bar
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: 4,
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

  /// Reusable Action Button (Delete / Share)
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
}
