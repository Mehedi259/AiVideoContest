import 'package:flutter/material.dart';
import 'package:trope/gen/assets.gen.dart';
import 'package:trope/view/widgets/active_button.dart';
import 'package:go_router/go_router.dart';
import '../../../app/routes/app_routes.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 300),
              Center(
                child: Assets.images.mainLogo.image(
                  width: 194.68,
                  height: 76.91,
                ),
              ),
              const Spacer(),
              ActiveButton(
                text: 'Sign in',
                onPressed: () {
                  context.push(Routes.signIn);
                },
              ),
              const SizedBox(height: 10),
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
                    context.push(Routes.signUp);
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
