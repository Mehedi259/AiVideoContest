import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Prommt/gen/assets.gen.dart';
import '../../../app/routes/app_routes.dart';
import '../../../controllers/profile_controller.dart';
import '../../widgets/navigation_bar.dart';
import '../../widgets/profile_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProfileController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontFamily: "Raleway",
            fontWeight: FontWeight.w700,
            fontSize: 20,
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

        if (controller.profile.value == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Failed to load profile',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.refreshProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004AAD),
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final profile = controller.profile.value!;
        final baseUrl = "http://10.10.7.86:8000";

        return RefreshIndicator(
          onRefresh: controller.refreshProfile,
          color: const Color(0xFF004AAD),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                /// Profile Info Container
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF004AAD),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          /// Profile Picture
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: ClipOval(
                              child: profile.profilePicture.isNotEmpty
                                  ? CachedNetworkImage(
                                imageUrl: profile.profilePicture.startsWith('http')
                                    ? profile.profilePicture
                                    : '$baseUrl${profile.profilePicture}',
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: Colors.grey[800],
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Assets.images.profilePicture.image(
                                      width: 48,
                                      height: 48,
                                      fit: BoxFit.cover,
                                    ),
                              )
                                  : Assets.images.profilePicture.image(
                                width: 48,
                                height: 48,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          /// Status Dot
                          Positioned(
                            top: 36,
                            left: 36,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: const Color(0xFF004AAD),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),

                      /// Username + Handle + Fire Counter
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile.fullname.toUpperCase(),
                              style: const TextStyle(
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white,
                                letterSpacing: -0.5,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),

                            /// Handle + Fire + Counter
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "@${profile.username}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFFB0B3B8),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 6),

                                /// Fire Icon
                                Assets.icons.fire.image(width: 9, height: 11),
                                const SizedBox(width: 2),

                                /// Vote Counter
                                Obx(() => Text(
                                  "${controller.voteCount.value}",
                                  style: const TextStyle(
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                    color: Colors.white,
                                  ),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                /// Card Section
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      ProfileCard(
                        icon: Assets.icons.myAccount.path,
                        title: "My Account",
                        subtitle: "Make changes to your account",
                        onTap: () => context.go(Routes.myAccount),
                      ),
                      ProfileCard(
                        icon: Assets.icons.uplodedVideo.path,
                        title: "Uploaded Video",
                        subtitle: "See your uploaded video",
                        onTap: () => context.go(Routes.uploadedVideos),
                      ),
                      ProfileCard(
                        icon: Assets.icons.votedVideo.path,
                        title: "Voted Video",
                        subtitle: "Videos you have voted for",
                        onTap: () => context.go(Routes.votedVideos),
                      ),
                      ProfileCard(
                        icon: Assets.icons.badges.path,
                        title: "Badges",
                        subtitle: "See your badges",
                        onTap: () => context.go(Routes.badges),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                /// Logout Button
                OutlinedButton(
                  onPressed: () => controller.logout(context),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40),
                    side: const BorderSide(color: Color(0xFF004AAD), width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// Delete Account Button
                ElevatedButton(
                  onPressed: () => controller.deleteAccount(context),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40),
                    backgroundColor: const Color(0xFFE53935),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    "Delete Account",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),

      /// Bottom Navigation Bar
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