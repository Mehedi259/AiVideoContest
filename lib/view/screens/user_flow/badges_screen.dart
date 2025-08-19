import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../gen/assets.gen.dart';
import '../../widgets/navigation_bar.dart';
import '../../../app/routes/app_routes.dart';

class BadgeScreen extends StatelessWidget {
  const BadgeScreen({super.key});

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
          "Badge",
          style: TextStyle(
            fontFamily: "Raleway",
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),

            /// Badge Card
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  /// Badge Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      Assets.images.congratulation.path,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 12),

                  /// Badge Text
                  const Text(
                    "“From the shadows, you rose… With 769 votes the Halloween throne is yours!”",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            /// Download Button
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download, color: Colors.white),
              label: const Text("Download"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF004AAD),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            )
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
