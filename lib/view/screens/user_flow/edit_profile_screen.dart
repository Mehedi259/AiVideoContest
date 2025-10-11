import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Prommt/gen/assets.gen.dart';
import '../../../app/routes/app_routes.dart';
import '../../../controllers/edit_profile_controller.dart';
import '../../widgets/navigation_bar.dart';

class EditInformationScreen extends StatefulWidget {
  const EditInformationScreen({super.key});

  @override
  State<EditInformationScreen> createState() => _EditInformationScreenState();
}

class _EditInformationScreenState extends State<EditInformationScreen> {
  late EditProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(EditProfileController());
  }

  @override
  Widget build(BuildContext context) {
    final baseUrl = "http://10.10.7.86:8000";

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Assets.icons.arrowLeft.image(width: 22, height: 22),
          onPressed: () => context.go(Routes.myAccount),
        ),
        centerTitle: true,
        title: const Text(
          "Edit Information",
          style: TextStyle(
            fontFamily: "Raleway",
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF004AAD)),
          );
        }

        final profile = controller.profile.value;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              /// Profile Avatar with camera overlay
              Column(
                children: [
                  GestureDetector(
                    onTap: controller.pickImage,
                    child: Stack(
                      children: [
                        // Profile picture
                        Obx(() {
                          // Show selected image if available
                          if (controller.hasImageSelected.value) {
                            if (kIsWeb && controller.webImageBytes != null) {
                              return CircleAvatar(
                                radius: 50,
                                backgroundImage: MemoryImage(controller.webImageBytes!),
                              );
                            } else if (controller.imageFile != null) {
                              return CircleAvatar(
                                radius: 50,
                                backgroundImage: FileImage(controller.imageFile!),
                              );
                            }
                          }

                          // Show existing profile picture
                          if (profile?.profilePicture != null &&
                              profile!.profilePicture.isNotEmpty) {
                            return CircleAvatar(
                              radius: 50,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: profile.profilePicture.startsWith('http')
                                      ? profile.profilePicture
                                      : '$baseUrl${profile.profilePicture}',
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                  placeholder: (context, url) => Container(
                                    color: Colors.grey[800],
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Assets.images.profilePicture.image(
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                ),
                              ),
                            );
                          }

                          // Fallback
                          return CircleAvatar(
                            radius: 50,
                            backgroundImage: Assets.images.profilePicture.provider(),
                          );
                        }),

                        // Camera icon
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Assets.icons.camera.image(width: 20, height: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    profile?.fullname ?? "Loading...",
                    style: const TextStyle(
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "@${profile?.username ?? ''}",
                    style: const TextStyle(
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFFB0B3B8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              /// Full Name Input
              TextField(
                controller: controller.fullnameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "What's your full name?",
                  hintStyle: const TextStyle(color: Color(0xFFB0B3B8)),
                  filled: true,
                  fillColor: const Color(0xFF1E1E1E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              /// Update Profile Button
              Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isUpdating.value
                      ? null
                      : controller.updateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004AAD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    disabledBackgroundColor: Colors.grey,
                  ),
                  child: controller.isUpdating.value
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    "Update Profile",
                    style: TextStyle(
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
            ],
          ),
        );
      }),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: 4,
        onTap: (index) {
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
        },
      ),
    );
  }
}