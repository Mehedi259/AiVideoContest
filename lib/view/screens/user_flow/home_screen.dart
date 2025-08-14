import 'package:flutter/material.dart';
import 'package:trope/view/widgets/custom_video_card.dart';
import 'package:trope/view/widgets/custom_drawer.dart';
import 'package:trope/gen/assets.gen.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Scaffold key
      backgroundColor: Colors.black,
      drawer: const CustomDrawer(), // Your custom drawer widget
      body: SafeArea(
        child: Column(
          children: [
            // Topbar
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

            // Box with "Halloween Theme"
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
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

            // Videos Grid
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
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
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}
