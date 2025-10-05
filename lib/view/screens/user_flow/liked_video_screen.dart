import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:Prommt/gen/assets.gen.dart';
import '../../../app/routes/app_routes.dart';
import '../../widgets/navigation_bar.dart';
import '../../widgets/liked_video_card.dart';

class LikedVideosScreen extends StatefulWidget {
  const LikedVideosScreen({super.key});

  @override
  State<LikedVideosScreen> createState() => _LikedVideosScreenState();
}

class _LikedVideosScreenState extends State<LikedVideosScreen> {
  int _currentIndex = 1; // Liked tab is active

  // Dummy list for liked videos
  final List<Map<String, String>> likedVideos = [
    {
      'title': 'Halloween Coffee',
      'username': '@piash374',
      'views': '7M views',
      'image': Assets.images.videoOne.path,
    },

    {
      'title': 'Halloween Coffee',
      'username': '@piash374',
      'views': '500k views',
      'image': Assets.images.videoTwo.path,
    },

    {
      'title': 'Halloween Coffee',
      'username': '@piash374',
      'views': '6M views',
      'image': Assets.images.videoThree.path,
    },

    {
      'title': 'Halloween Coffee',
      'username': '@piash374',
      'views': '2M views',
      'image': Assets.images.videoTwo.path,
    },

    {
      'title': 'Halloween Coffee',
      'username': '@piash374',
      'views': '4M views',
      'image': Assets.images.videoOne.path,
    },

    {
      'title': 'Halloween Coffee',
      'username': '@piash374',
      'views': '100M views',
      'image': Assets.images.videoOne.path,
    },

  ];

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
          children: likedVideos.map((video) {
            return LikedVideoCard(
              imagePath: video['image']!,
              title: video['title']!,
              user: video['username']!,
              views: video['views']!,
              onTap: () {
                GoRouter.of(context).go(Routes.videoPlay);
              },
            );
          }).toList(),
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
}
