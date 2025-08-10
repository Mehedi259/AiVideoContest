import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 300),
            // Logo
            Center(
              child: Image.asset(
                'assets/images/MainLogo.png',
                width: 194.68,
                height: 76.91,
              ),
            ),

            const Spacer(),

            // Sign In Button
            SizedBox(
              height: 50.0,
              width: 348.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004AAD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/signIn');
                },
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Sign Up Button
            SizedBox(
              height: 50.0,
              width: 348.0,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF004AAD),
                  side: const BorderSide(color: Color(0xFF004AAD), width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/signUp');
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
