import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:Tright/gen/assets.gen.dart';

import '../../../app/routes/app_routes.dart';
import '../../widgets/navigation_bar.dart';
import '../../widgets/profile_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontFamily: "Raleway",
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            /// Profile Info Container
            Container(
              width: double.infinity,
              height: 89,
              decoration: BoxDecoration(
                color: const Color(0xFF004AAD),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      /// Profile Picture with Border
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            Assets.images.profilePicture.path,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      /// Status Dot
                      Positioned(
                        top: 36,
                        left: 36,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: const Color(0xFF004AAD),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),

                  /// Username + Handle + Fire Counter
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "JOHN DOE",
                        style: TextStyle(
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),

                      /// Handle + Fire + Counter
                      Row(
                        children: [
                          const Text(
                            "@jhondoe1",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFFB0B3B8),
                            ),
                          ),
                          const SizedBox(width: 6),

                          /// Fire Icon
                          Image.asset(
                            Assets.icons.fire.path,
                            width: 9,
                            height: 11,
                          ),
                          const SizedBox(width: 2),

                          /// Counter
                          const Text(
                            "12",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                              height: 12 / 11, // line-height = 12px
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// Card Section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ProfileCard(
                    icon: Assets.icons.myAccount.path,
                    title: "My Account",
                    subtitle: "Make changes to your account",
                    onTap: () {
                      GoRouter.of(context).go(Routes.myAccount);
                    },
                  ),
                  ProfileCard(
                    icon: Assets.icons.uplodedVideo.path,
                    title: "Uploaded Video",
                    subtitle: "See your uploaded video",
                    onTap: () {
                      GoRouter.of(context).go(Routes.uploadedVideos);
                    },
                  ),
                  ProfileCard(
                    icon: Assets.icons.votedVideo.path,
                    title: "Voted Video",
                    subtitle: "Privacy policy and terms",
                    onTap: () {
                      GoRouter.of(context).go(Routes.votedVideos);
                    },
                  ),
                  ProfileCard(
                    icon: Assets.icons.badges.path,
                    title: "Badges",
                    subtitle: "See your badges",
                    onTap: () {
                      GoRouter.of(context).go(Routes.badges);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            /// Logout Button
            OutlinedButton(
              onPressed: () {
                GoRouter.of(context).go(Routes.signIn);
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
                side: const BorderSide(color: Color(0xFF004AAD), width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                foregroundColor: Colors.white,
              ),
              child: const Text(
                "Logout",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Delete Account Button
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go(Routes.signUp);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
                backgroundColor: const Color(0xFFE53935),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                foregroundColor: Colors.white,
              ),
              child: const Text(
                "Delete Account",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),

      /// Bottom Navigation Bar
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
