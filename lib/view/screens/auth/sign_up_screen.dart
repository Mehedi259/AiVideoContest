import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Prommt/gen/assets.gen.dart';
import 'package:Prommt/view/widgets/text_input_box.dart';
import 'package:Prommt/view/widgets/password_input.dart';
import 'package:Prommt/view/widgets/active_button.dart';
import 'package:go_router/go_router.dart';
import '../../../app/routes/app_routes.dart';
import '../../../controllers/sign_up_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController controller = Get.put(SignUpController());

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

              /// Full Name Input Field
              TextInputBox(
                controller: controller.fullnameController,
                label: "Full Name",
                hintText: "Enter your full name",
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Assets.icons.user.image(width: 20, height: 20),
                ),
              ),
              const SizedBox(height: 20),

              /// Username Input Field
              TextInputBox(
                controller: controller.usernameController,
                label: "Username",
                hintText: "Enter your user name",
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Assets.icons.user.image(width: 20, height: 20),
                ),
              ),
              const SizedBox(height: 20),

              /// Email Input Field
              TextInputBox(
                controller: controller.emailController,
                label: "Email",
                hintText: "Enter your email",
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Assets.icons.email.image(width: 20, height: 20),
                ),
              ),
              const SizedBox(height: 20),

              /// Password Input Field
              PasswordInput(
                controller: controller.passwordController,
                label: "Password",
              ),
              const SizedBox(height: 20),

              /// Confirm Password Input Field
              PasswordInput(
                controller: controller.confirmPasswordController,
                label: "Confirm Password",
              ),
              const SizedBox(height: 30),

              /// Sign Up Button with Loading State
              Obx(() => controller.isLoading.value
                  ? const CircularProgressIndicator(color: Color(0xFF004AAD))
                  : ActiveButton(
                text: "Sign up",
                onPressed: () async {
                  final success = await controller.register();
                  if (success) {
                    GoRouter.of(context).push(
                      Routes.OtpScreenAfterRegistration,
                      extra: controller.emailController.text.trim(),
                    );
                  }
                },
              )),
              const SizedBox(height: 20),

              /// Navigate to Sign In
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Do you have an account?",
                      style: TextStyle(color: Colors.white)),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).go(Routes.signIn);
                    },
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

              /// Divider with "Or"
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

              /// Social Login Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(onTap: () {}, child: Assets.icons.apple.image(height: 48)),
                  const SizedBox(width: 24),
                  InkWell(onTap: () {}, child: Assets.icons.google.image(height: 48)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}