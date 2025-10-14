import 'package:flutter/material.dart';
import 'package:Prommt/gen/assets.gen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../app/routes/app_routes.dart';
import '../../../controllers/video_competetion_controller.dart';
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

  @override
  void initState() {
    super.initState();
    // Fetch active theme when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VideoCompetitionController>().fetchActiveTheme();
    });
  }

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
                    onTap: () => context.go(Routes.home),
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
                  const SizedBox(width: 46),
                ],
              ),
            ),

            // Content
            Expanded(
              child: Consumer<VideoCompetitionController>(
                builder: (context, controller, child) {
                  if (controller.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Color(0xFF004AAD)),
                    );
                  }

                  if (controller.error != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red, size: 48),
                          const SizedBox(height: 16),
                          Text(
                            'Error loading theme',
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () => controller.fetchActiveTheme(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  final theme = controller.activeTheme;

                  if (theme == null) {
                    return const Center(
                      child: Text(
                        'No active theme available',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Theme Banner Image
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            color: Colors.black,
                            child: theme.themeCoverImageUrl.isNotEmpty
                                ? Image.network(
                              theme.themeCoverImageUrl,
                              fit: BoxFit.cover,
                            )
                                : Assets.images.themeImage.image(fit: BoxFit.cover),
                          ),
                        ),


                        const SizedBox(height: 24),

                        // Theme Name
                        Text(
                          theme.themeName,
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),

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

                        // Dynamic Rules from API
                        _buildRule("Theme Rules", theme.rules),


                      ],
                    ),
                  );
                },
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