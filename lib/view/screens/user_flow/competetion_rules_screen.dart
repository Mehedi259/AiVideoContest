import 'package:flutter/material.dart';
import 'package:Prommt/gen/assets.gen.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes/app_routes.dart';
import '../../widgets/navigation_bar.dart';
import '../../widgets/custom_drawer.dart';

class CompetetionRulesScreen extends StatefulWidget {
  const CompetetionRulesScreen({super.key});

  @override
  State<CompetetionRulesScreen> createState() => _CompetetionRulesScreenState();
}

class _CompetetionRulesScreenState extends State<CompetetionRulesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

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
        context.go(Routes.uploadVideos);
        break;
      case 3:
        context.go(Routes.winner);
        break;
      case 4:
        context.go(Routes.profile);
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
            // Top AppBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.go(Routes.home), // 🔹 back to previous screen
                    child: Assets.icons.backButton.image(width: 30, height: 30),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Video Competition",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 46), // to balance back button
                ],
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Banner Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Assets.images.themeImage.image(
                        width: double.infinity,
                        height: 127,
                        //fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Competition Rules Title
                    const Text(
                      "Competition Rules",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Rules Body (Bullet style)
                    _buildRule(
                      "Theme Required",
                      "All videos must follow a Halloween theme — spooky, funny, scary, creepy, or creative.",
                    ),
                    _buildRule(
                      "Video Length",
                      "Each video should be between 15 to 60 seconds long.",
                    ),
                    _buildRule(
                      "Original Content Only",
                      "No copyrighted material. All videos must be created by you.",
                    ),
                    _buildRule(
                      "Upload Deadline",
                      "Submissions must be uploaded by October 30th, 11:59 PM (local time).",
                    ),
                    _buildRule(
                      "No Harmful Content",
                      "No real violence, hate speech, gore, or anything that violates community standards.",
                    ),
                    _buildRule(
                      "One Entry Per User",
                      "Each participant can submit only one video per contest cycle.",
                    ),
                    _buildRule(
                      "Voting System",
                      "Winners are chosen based on views + likes. Fake engagement will result in disqualification.",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // 🔹 Same navigation bar as HomeScreen
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }

  // Helper method for rules with bullets
  Widget _buildRule(String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "• $body",
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.white70,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
