import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trope/gen/assets.gen.dart';

import '../../../app/routes/app_routes.dart';
import '../../widgets/navigation_bar.dart';

class UploadedVideoScreen extends StatelessWidget {
  const UploadedVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Halloween Theme",
              style: TextStyle(
                fontFamily: "Raleway",
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xFF004AAD),
              ),
            ),
            const SizedBox(height: 12),

            /// Video Card
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  /// Thumbnail
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      Assets.images.like1.path,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// Bottom Info
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.black, Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Dinner Event",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "472 views",
                            style: TextStyle(
                              color: Color(0xFFB0B3B8),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.delete, color: Colors.red),
                  label: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(width: 16),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share, color: Colors.white),
                  label: const Text(
                    "Share",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      /// Bottom Nav
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
