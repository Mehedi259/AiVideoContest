import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trope/gen/assets.gen.dart';
import 'package:trope/view/widgets/hover_effect_button.dart';

import '../../../app/routes/app_routes.dart';  // <-- import added

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        isButtonActive = _emailController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 30,
              left: 30,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Assets.icons.backButton.image(
                  width: 30,
                  height: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 138),
                  const Text(
                    'Forgot password',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      letterSpacing: -0.5,
                      color: Colors.white,
                      height: 20 / 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Please enter your email to reset the password',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      letterSpacing: -0.5,
                      color: Color(0xFFB0B3B8),
                      height: 20 / 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Your Email',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      letterSpacing: -0.5,
                      color: Colors.white,
                      height: 20 / 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFB0B3B8),
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: TextField(
                      controller: _emailController,
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: -0.5,
                        color: Colors.white,
                        height: 20 / 14,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: -0.5,
                          color: Color(0xFFB0B3B8),
                          height: 20 / 14,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 26),
                  HoverEffectButton(
                    isActive: isButtonActive,
                    onTap: () {
                      if (isButtonActive) {
                        GoRouter.of(context).push(
                          Routes.otp,
                          extra: _emailController.text.trim(),
                        );
                      }
                    },
                    text: 'Reset Password',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
