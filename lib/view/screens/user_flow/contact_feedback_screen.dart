import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:Prommt/gen/assets.gen.dart';
import '../../../app/routes/app_routes.dart';
import '../../../controllers/contact_feedback_controller.dart';
import '../../widgets/navigation_bar.dart';
import '../../widgets/custom_drawer.dart';

class ContactFeedbackScreen extends StatefulWidget {
  const ContactFeedbackScreen({super.key});

  @override
  State<ContactFeedbackScreen> createState() => _ContactFeedbackScreenState();
}

class _ContactFeedbackScreenState extends State<ContactFeedbackScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _messageController = TextEditingController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        context.go(Routes.home);
        break;
      case 1:
        context.go(Routes.likedVideos);
        break;
      case 2:
        context.go(Routes.uploadVideos);
        break;
      case 3:
        context.go(Routes.winner);
        break;
      case 4:
        context.go(Routes.profile);
        break;
    }
  }

  Future<void> _submitFeedback() async {
    final controller = context.read<ContactFeedbackController>();
    final success = await controller.submitFeedback(_messageController.text);

    if (success && mounted) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Feedback submitted successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Clear the text field
      _messageController.clear();
    } else if (mounted && controller.error != null) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(controller.error!),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            // Top AppBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.go(Routes.home),
                    child: Assets.icons.backButton.image(width: 30, height: 30),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Contact & Feedback",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 46),
                ],
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Message Field
                    _buildField(
                      label: "Message",
                      hint: "Write down your message",
                      maxLines: 5,
                      controller: _messageController,
                    ),
                    const SizedBox(height: 40),

                    // Send Button
                    Center(
                      child: Consumer<ContactFeedbackController>(
                        builder: (context, controller, child) {
                          return ElevatedButton(
                            onPressed: controller.isLoading ? null : _submitFeedback,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF004AAD),
                              disabledBackgroundColor: const Color(0xFF004AAD),
                              minimumSize: const Size(274, 44),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                            ),
                            child: controller.isLoading
                                ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                                : const Text(
                              "Send",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }

  Widget _buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xFFB0B3B8),
            ),
            filled: true,
            fillColor: const Color(0xFF1C1C1E),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}