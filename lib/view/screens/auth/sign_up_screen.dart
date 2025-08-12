import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trope/gen/assets.gen.dart';
import 'package:trope/view/widgets/text_input_box.dart';
import 'package:trope/view/widgets/password_input.dart';
import 'package:trope/view/widgets/active_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              const Text(
                "Create an account",
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Color(0xFF004AAD),
                ),
              ),
              const SizedBox(height: 40),

              // Username
              TextInputBox(
                controller: _usernameController,
                label: "Username",
                hintText: "Enter your full name",
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Assets.icons.user.image(width: 20, height: 20), // user.png icon
                ),
              ),
              const SizedBox(height: 20),

              // Email
              TextInputBox(
                controller: _emailController,
                label: "Email",
                hintText: "Enter your email",
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Assets.icons.email.image(width: 20, height: 20),
                ),
              ),
              const SizedBox(height: 20),

              // Password
              PasswordInput(
                controller: _passwordController,
                label: "Password",
              ),
              const SizedBox(height: 20),

              // Confirm Password
              PasswordInput(
                controller: _confirmPasswordController,
                label: "Confirm Password",
              ),
              const SizedBox(height: 30),

              // Sign Up Button
              ActiveButton(
                text: "Sign up",
                onPressed: () {
                  // TODO: Add signup logic
                  print("Username: ${_usernameController.text}");
                  print("Email: ${_emailController.text}");
                  print("Password: ${_passwordController.text}");
                  print("Confirm Password: ${_confirmPasswordController.text}");
                },
              ),
              const SizedBox(height: 20),

              // Already have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Do you have an account?", style: TextStyle(color: Colors.white)),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Text(
                      " Sign in",
                      style: TextStyle(
                        color: Color(0xFF004AAD),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Or
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade700)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("Or", style: TextStyle(color: Colors.white)),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade700)),
                ],
              ),
              const SizedBox(height: 16),

              // Social Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Assets.icons.apple.image(height: 48),
                  ),
                  const SizedBox(width: 24),
                  InkWell(
                    onTap: () {},
                    child: Assets.icons.google.image(height: 48),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
