import 'package:flutter/material.dart';
import 'package:trope/view/widgets/active_button.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20), // Side padding for better design
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

              // Sign In Button (Reusable)
              ActiveButton(
                text: 'Sign in',
                onPressed: () {
                  Navigator.pushNamed(context, '/signIn');
                },
              ),

              const SizedBox(height: 10),

              // Sign Up Button (Full width)
              SizedBox(
                height: 50.0,
                width: double.infinity,
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
      ),
    );
  }
}
