import 'package:flutter/material.dart';
import 'package:trope/gen/assets.gen.dart';
import '../../../app/routes/app_routes.dart';
import '../../widgets/navigation_bar.dart';
import 'package:go_router/go_router.dart';

class WinnerScreen extends StatelessWidget {
  const WinnerScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Winners",
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            left: 20,
            child: Container(
              width: 161,
              height: 23,
              decoration: BoxDecoration(
                color: const Color(0xFF004AAD),
                borderRadius: BorderRadius.circular(50),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Halloween Theme',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.white,
                  height: 0.625,
                ),
              ),
            ),
          ),

          // "Night House" Text
          const Positioned(
            top: 50,
            left: 20,
            child: Text(
              'Night House',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Colors.white,
                height: 0.42,
              ),
              textAlign: TextAlign.center,
            ),
          ),


          //user id
          const Positioned(
            top: 75,
            left: 20,
            child: Text(
              '@junaid982',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(0xFFB0B3B8),
                height: 0.42,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Video Image Container
          Positioned(
            top: 105,
            left: 20,
            child: Container(
              width: 353,
              height: 181,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: Assets.images.videoTwo.provider(), // <-- correct provider
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Assets.icons.playIcon.image(
                  width: 46,
                  height: 44.64,
                ),
              ),
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: 3, // Winner screen active
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
