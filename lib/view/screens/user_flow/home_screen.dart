import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:Prommt/view/widgets/custom_video_card.dart';
import 'package:Prommt/view/widgets/custom_drawer.dart';
import 'package:Prommt/view/widgets/navigation_bar.dart';
import 'package:Prommt/gen/assets.gen.dart';

import '../../../app/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  bool _showTop3 = false;

  final List<Map<String, String>> videos = [
    {
      'title': 'Halloween Coffee',
      'username': '@piash374',
      'views': '7M views',
      'image': Assets.images.videoOne.path,
    },
    {
      'title': 'Night House',
      'username': '@junaid982',
      'views': '10M views',
      'image': Assets.images.videoTwo.path,
    },
    {
      'title': 'Halloween Event',
      'username': '@farab039',
      'views': '500K views',
      'image': Assets.images.videoThree.path,
    },
    {
      'title': 'Halloween Event',
      'username': '@mehedi039',
      'views': '1B views',
      'image': Assets.images.videoFour.path,
    },
    {
      'title': 'Halloween Event',
      'username': '@farab039',
      'views': '263K views',
      'image': Assets.images.videoOne.path,
    },
    {
      'title': 'Halloween Event',
      'username': '@farab039',
      'views': '284K views',
      'image': Assets.images.videoTwo.path,
    },
  ];

  final List<Map<String, String>> top3Videos = [
    {
      'title': 'Billion View Clip',
      'username': '@mehedi039',
      'views': '1B views',
      'image': Assets.images.videoFour.path,
      'rank': 'Top 1',
    },
    {
      'title': 'Night House',
      'username': '@junaid982',
      'views': '10M views',
      'image': Assets.images.videoTwo.path,
      'rank': 'Top 2',
    },
    {
      'title': 'Halloween Coffee',
      'username': '@piash374',
      'views': '7M views',
      'image': Assets.images.videoOne.path,
      'rank': 'Top 3',
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
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      IconButton(
                        onPressed: () {
                          GoRouter.of(context).go(Routes.notification);
                        },
                        icon: Assets.icons.notification.image(width: 22, height: 22),
                      ),
                      Positioned(
                        right: 14,
                        top: 10,
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                            color: Color(0xFF004AAD),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                width: 198,
                height: 23,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: const Color(0xFF004AAD), width: 1),
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: ClipRRect(
                        //borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          Assets.images.themeImage.path,
                          width: double.infinity,
                          height: 124.77,
                          //fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 15),
                        _buildToggleButton("All Videos", !_showTop3),
                        const SizedBox(width: 10),
                        _buildToggleButton("Top 3 Videos", _showTop3),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        children: (_showTop3 ? top3Videos : videos).map((video) {
                          return CustomVideoCard(
                            imagePath: video['image']!,
                            title: video['title']!,
                            user: video['username']!,
                            views: video['views']!,
                            rank: video['rank'],
                            onTap: () {
                              GoRouter.of(context).go(Routes.videoPlay);
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

  Widget _buildToggleButton(String text, bool active) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showTop3 = text == "Top 3 Videos";
        });
      },
      child: Container(
        width: text == "All Videos" ? 104 : 116,
        height: 30,
        decoration: BoxDecoration(
          color: active ? const Color(0xFF004AAD) : const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(50),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: active ? FontWeight.w500 : FontWeight.w400,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
