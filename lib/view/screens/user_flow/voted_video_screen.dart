import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trope/gen/assets.gen.dart';
import '../../widgets/navigation_bar.dart';
import '../../../app/routes/app_routes.dart';

class VotedVideoScreen extends StatelessWidget {
  const VotedVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            GoRouter.of(context).go(Routes.profile);
          }
        ),
        title: const Text(
          "Voted Video",
          style: TextStyle(
            fontFamily: "Raleway",
            fontSize: 18,
            fontWeight: FontWeight.w700,
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
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF004AAD),
              ),
            ),
            const SizedBox(height: 12),

            /// Voted Video Card
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black,
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  /// Thumbnail
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      Assets.images.like4.path,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// Info
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 45,
                      color: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Dinner Event\n@zarif143",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
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
