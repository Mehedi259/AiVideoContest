import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/routes/app_routes.dart';
import 'package:Prommt/gen/assets.gen.dart'; // FlutterGen import

class SuccessDialog extends StatelessWidget {
  final String message;

  const SuccessDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        width: 344,
        height: 341,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 20,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Stack(
          children: [
            /// Cross button (top right)
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () => GoRouter.of(context).go(Routes.profile),
                child: Container(
                  width: 24,
                  height: 24,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0x66999999),
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            /// Main content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Success image
                SizedBox(
                  width: 106,
                  height: 106,
                  child: Assets.images.passwordChangedSuccessfully.image(),
                ),
                const SizedBox(height: 24),

                /// Message
                SizedBox(
                  width: 251,
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      height: 1.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                /// Continue Button
                SizedBox(
                  width: 298,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => GoRouter.of(context).go(Routes.profile),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004AAD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shadowColor: const Color(0x1A000000),
                      elevation: 4,
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Color(0xFFFDFDFD),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
