import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/routes/app_routes.dart';
import '../../widgets/navigation_bar.dart';
import '../../widgets/success_dialog.dart'; // SuccessDialog import করো

class EditInformationScreen extends StatelessWidget {
  const EditInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => GoRouter.of(context).go(Routes.myAccount),
        ),
        title: const Text(
          "Edit Information",
          style: TextStyle(
            fontFamily: "Raleway",
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            /// Profile Avatar
            Column(
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage("assets/images/profile.png"),
                ),
                const SizedBox(height: 12),
                const Text(
                  "John Doe",
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "@jhondoe1",
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xFFB0B3B8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            /// First name field
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "What’s your first name?",
                hintStyle: const TextStyle(color: Color(0xFFB0B3B8)),
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),

            /// Last name field
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "And your last name?",
                hintStyle: const TextStyle(color: Color(0xFFB0B3B8)),
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            /// Update button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const SuccessDialog(
                      message: "Profile information changed successfully",
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004AAD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Update Profile",
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white,
                  ),
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
