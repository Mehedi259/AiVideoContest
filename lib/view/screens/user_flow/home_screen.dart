import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trope/view/widgets/custom_video_card.dart';
import 'package:trope/view/widgets/custom_drawer.dart';
import 'package:trope/view/widgets/navigation_bar.dart';
import 'package:trope/gen/assets.gen.dart';

import '../../../app/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  final List<Map<String, String>> videos = [
    {
      'title': 'Halloween Coffee',
      'username': '@piash374',
      'views': '781 views',
      'image': Assets.images.videoOne.path,
    },
    {
      'title': 'Night House',
      'username': '@junaid982',
      'views': '334 views',
      'image': Assets.images.videoTwo.path,
    },
    {
      'title': 'Halloween Event',
      'username': '@farab039',
      'views': '500 views',
      'image': Assets.images.videoThree.path,
    },
    {
      'title': 'Halloween Event',
      'username': '@farab039',
      'views': '500 views',
      'image': Assets.images.videoFour.path,
    },
    {
      'title': 'Halloween Event',
      'username': '@farab039',
      'views': '500 views',
      'image': Assets.images.videoOne.path,
    },
    {
      'title': 'Halloween Event',
      'username': '@farab039',
      'views': '500 views',
      'image': Assets.images.videoTwo.path,
    },
  ];

  void _onNavTap(int index) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Sticky Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    child: const Icon(Icons.menu, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Text(
                      "Theme Competition",
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Sticky Theme Tag
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 198,
                height: 23,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Color(0xFF004AAD), width: 1),
                ),
                child: const Center(
                  child: Text(
                    "Halloween Theme",
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // 🔹 Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Banner
                    Container(
                      width: 362,
                      height: 129,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(Assets.images.themeImage.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Video list
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        children: videos.map((video) {
                          return CustomVideoCard(
                            imagePath: video['image']!,
                            title: video['title']!,
                            user: video['username']!,
                            views: video['views']!,
                            onTap: () {
                              Navigator.pushNamed(context, '/home_vote');
                            },
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
