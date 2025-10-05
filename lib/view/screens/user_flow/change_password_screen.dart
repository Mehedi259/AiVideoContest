import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:Prommt/gen/assets.gen.dart'; // FlutterGen import
import '../../../app/routes/app_routes.dart';
import '../../widgets/navigation_bar.dart';
import '../../widgets/success_dialog.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      /// Custom AppBar with back arrow (Arrow-Left.png from FlutterGen)
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Assets.icons.arrowLeft.image(width: 22, height: 22),
          onPressed: () => GoRouter.of(context).go(Routes.myAccount),
        ),
        centerTitle: true,
        title: const Text(
          "Change Password",
          style: TextStyle(
            fontFamily: "Raleway",
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),

      /// Scrollable body
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Instruction Text
            const Text(
              "Enter your old password and set a new one to regain access.",
              style: TextStyle(
                fontFamily: "Raleway",
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFFB0B3B8),
              ),
            ),
            const SizedBox(height: 24),

            /// Old Password
            _buildPasswordField(label: "Old Password"),

            const SizedBox(height: 20),

            /// New Password
            _buildPasswordField(label: "New Password"),

            const SizedBox(height: 20),

            /// Confirm Password
            _buildPasswordField(label: "Confirm Password"),

            const SizedBox(height: 32),

            /// Update Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const SuccessDialog(
                      message: "Password changed successfully",
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
                  "Update",
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

  /// Reusable password field widget with label and placeholder
  Widget _buildPasswordField({required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Field Label
        Text(
          label,
          style: const TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.white,
            height: 1.0, // line-height: 100%
          ),
        ),
        const SizedBox(height: 8),

        /// Password Input Field
        TextField(
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "",
            hintStyle: const TextStyle(color: Color(0xFFB0B3B8)),
            filled: true,
            fillColor: const Color(0xFF1E1E1E),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF333333)),
            ),
          ),
        ),
      ],
    );
  }
}
