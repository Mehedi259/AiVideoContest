import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:Tright/gen/assets.gen.dart';

import '../../../app/routes/app_routes.dart';
import '../../widgets/navigation_bar.dart';
import '../../widgets/liked_video_card.dart';

class VotedVideoScreen extends StatelessWidget {
  const VotedVideoScreen({super.key});

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
          "Voted Video",
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

}
