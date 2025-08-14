import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 228,
      backgroundColor: const Color(0xFF1C1C1E),
      shape: const Border(
        right: BorderSide(color: Color(0xFF424242), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 61),

          // Profile Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        'assets/images/profile_picture.jpg',
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Image.asset(
                        'assets/icons/profile_active_dot.png',
                        width: 12,
                        height: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "HELLO",
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFFB0B3B8),
                        letterSpacing: -0.01,
                      ),
                    ),
                    Text(
                      "JOHN DOE",
                      style: const TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                        letterSpacing: -0.01,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Menu Items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // Competition
                _MenuItem(
                  iconPath: 'assets/icons/competetion.png',
                  title: "COMPETITION",
                  textColor: const Color(0xFF004AAD),
                  onTap: () {
                    Navigator.pushNamed(context, '/competition');
                  },
                ),
                const SizedBox(height: 12),

                // Contact Us & Feedback
                _MenuItem(
                  iconPath: 'assets/icons/contactUs.png',
                  title: "CONTACT US & FEEDBACK",
                  textColor: Colors.white,
                  height: 72,
                  onTap: () {
                    Navigator.pushNamed(context, '/contact');
                  },
                ),
              ],
            ),
          ),

          const Spacer(),

          // Logout Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/welcome');
              },
              child: Container(
                height: 57,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Image.asset('assets/icons/logout.png', width: 24, height: 24),
                    const SizedBox(width: 8),
                    const Text(
                      "LOG OUT",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFFE22F2F),
                        letterSpacing: -0.01,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final Color textColor;
  final double height;
  final VoidCallback onTap;

  const _MenuItem({
    required this.iconPath,
    required this.title,
    required this.textColor,
    required this.onTap,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.asset(iconPath, width: 24, height: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: textColor,
                  letterSpacing: -0.01,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
