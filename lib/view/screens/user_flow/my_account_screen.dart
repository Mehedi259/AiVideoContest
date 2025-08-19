import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trope/gen/assets.gen.dart';

import '../../../app/routes/app_routes.dart';
import '../../widgets/navigation_bar.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () {
            GoRouter.of(context).go(Routes.profile);
          },
        ),
        title: const Text(
          "My Account",
          style: TextStyle(
            fontFamily: "Raleway",
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            /// Edit Information Card
            _buildAccountOption(
              context,
              icon: Assets.icons.myAccount.path,
              title: "Edit Information",
              subtitle: "Make changes to your information",
              onTap: () {
                GoRouter.of(context).go(Routes.editInformation);
              },
            ),
            const SizedBox(height: 16),

            /// Change Password Card
            _buildAccountOption(
              context,
              icon: Assets.icons.changePassword.path,
              title: "Change Password",
              subtitle: "You can change your password",
              onTap: () {
                GoRouter.of(context).go(Routes.changePassword);
              },
            ),
          ],
        ),
      ),

      /// Bottom Navigation
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: 4, // profile tab active
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

  Widget _buildAccountOption(
      BuildContext context, {
        required String icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(icon, width: 40, height: 40, fit: BoxFit.contain),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: "DM Sans",
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xFF004AAD),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: "DM Sans",
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                      color: Color(0xFFB0B3B8),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFFB0B3B8), size: 20),
          ],
        ),
      ),
    );
  }
}
