import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trope/gen/assets.gen.dart';

import '../../../app/routes/app_routes.dart';
import '../../widgets/navigation_bar.dart';

class LikedVideosScreen extends StatefulWidget {
  const LikedVideosScreen({super.key});

  @override
  State<LikedVideosScreen> createState() => _LikedVideosScreenState();
}

class _LikedVideosScreenState extends State<LikedVideosScreen> {
  int _currentIndex = 1; // Liked tab is active

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            "Your Liked Videos",
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700,
              fontSize: 20,
              height: 1, // line height fix
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: List.generate(5, (index) => _buildVideoCard(context)),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          switch (index) {
            case 0:
              context.go(Routes.home);
              break;
            case 1:
              context.go(Routes.likedVideos);
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

  Widget _buildVideoCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          /// Video Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Assets.images.like1.image(
              width: 353,
              height: 181,
              fit: BoxFit.cover,
            ),
          ),

          /// Play Icon
          Positioned(
            top: 159 - 109, // adjust relative position
            left: 353 / 2 - 13, // center horizontally (26/2 = 13)
            child: Assets.icons.playIcon.image(
              width: 26,
              height: 25,
            ),
          ),

          /// Bottom Info Container
          Positioned(
            top: 181 - 58, // stick at bottom
            child: Container(
              width: 353,
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0x1AD9D9D9),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title + Username
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Dinner Event",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          height: 1,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "@zarif143",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1,
                          color: Color(0xFFB0B3B8),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  /// Views
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "472 views",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        height: 1,
                        color: Color(0xFFB0B3B8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
