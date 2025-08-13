import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:trope/gen/assets.gen.dart';
import '../../../app/routes/app_routes.dart';
import '../../widgets/hover_effect_button.dart';
import 'package:go_router/go_router.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();
  bool isOtpComplete = false;

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Back button
            Positioned(
              top: 68,
              left: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Assets.icons.backButton.image(),
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 151),
                  const Text(
                    'Check your email',
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
                  Text(
                    'We sent a reset link to "${widget.email}"\nEnter 6 digit code that mentioned in the email',
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      letterSpacing: -0.5,
                      color: Color(0xFFB0B3B8),
                      height: 20 / 14,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // OTP input
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    autoDisposeControllers: false,
                    cursorColor: Colors.white,
                    textStyle: const TextStyle(
                      color: Colors.white, // OTP digit color white
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(12),
                      fieldHeight: 45,
                      fieldWidth: 45,
                      borderWidth: 2,
                      activeColor: const Color(0xFF004AAD),
                      selectedColor: const Color(0xFF004AAD),
                      inactiveColor: const Color(0xFFB0B3B8),
                      activeFillColor: Colors.transparent,
                      selectedFillColor: Colors.transparent,
                      inactiveFillColor: Colors.transparent,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: false,
                    onChanged: (value) {
                      setState(() {
                        isOtpComplete = value.length == 6;
                      });
                    },
                  ),

                  const SizedBox(height: 40),

                  // Verify Button
                  HoverEffectButton(
                    onTap: () {
                      if (isOtpComplete) {
                        context.go(Routes.passwordReset);
                      }
                    },
                    isActive: isOtpComplete,
                    text: "Verify Code",
                  ),

                  const SizedBox(height: 20),

                  // Resend Email Text
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Resend email API call
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: -0.5,
                            height: 20 / 14,
                          ),
                          children: [
                            TextSpan(
                              text: "Haven’t got the email yet? ",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                              text: "Resend email",
                              style: TextStyle(color: Color(0xFF004AAD)),
                            ),
                          ],
                        ),
                      ),
                    ),
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
