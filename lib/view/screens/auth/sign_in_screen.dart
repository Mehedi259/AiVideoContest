import 'package:flutter/material.dart';
import 'package:trope/gen/assets.gen.dart';
import 'package:trope/view/widgets/active_button.dart';
import 'package:trope/view/widgets/text_input_box.dart';
import 'package:trope/view/widgets/password_input.dart';
import 'package:go_router/go_router.dart';
import '../../../app/routes/app_routes.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

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
                "Sign in",
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Color(0xFF004AAD),
                ),
              ),
              const SizedBox(height: 40),
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
              PasswordInput(
                controller: _passwordController,
                label: "Password",
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _rememberMe = !_rememberMe;
                      });
                    },
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(3),
                        color: _rememberMe ? const Color(0xFF004AAD) : Colors.transparent,
                      ),
                      child: _rememberMe
                          ? const Icon(Icons.check, size: 14, color: Colors.white)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text("Remember me", style: TextStyle(color: Colors.white)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => context.push('/forgetPassword'),
                    child: const Text(
                      "Forget password?",
                      style: TextStyle(color: Color(0xFF004AAD)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ActiveButton(
                text: "Sign in",
                onPressed: () {
                  print("Email: ${_emailController.text}");
                  print("Password: ${_passwordController.text}");
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Do you have an account?", style: TextStyle(color: Colors.white)),
                  GestureDetector(
                    onTap: () => context.push(Routes.signUp),
                    child: const Text(
                      " Sign Up",
                      style: TextStyle(
                        color: Color(0xFF004AAD),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
