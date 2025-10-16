import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../gen/assets.gen.dart';
import '../../../controllers/badges_controller.dart';
import '../../widgets/navigation_bar.dart';
import '../../../app/routes/app_routes.dart';

class BadgeScreen extends StatefulWidget {
  const BadgeScreen({super.key});

  @override
  State<BadgeScreen> createState() => _BadgeScreenState();
}

class _BadgeScreenState extends State<BadgeScreen> {
  late BadgeController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(BadgeController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go(Routes.profile),
        ),
        title: const Text(
          "Badge",
          style: TextStyle(
            fontFamily: "Raleway",
            fontSize: 18,
            fontWeight: FontWeight.w700,
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

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(
                  controller.errorMessage.value,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.refreshBadges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004AAD),
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.badges.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.emoji_events_outlined,
                    color: Colors.grey,
                    size: 64
                ),
                const SizedBox(height: 16),
                const Text(
                  'No badges available yet',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Keep participating to earn badges!',
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshBadges,
          color: const Color(0xFF004AAD),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            itemCount: controller.badges.length,
            itemBuilder: (context, index) {
              final badge = controller.badges[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Username & Votes Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '@${badge.username}',
                        style: const TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xFF004AAD),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1C1C1E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${badge.totalVotes} votes',
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// Message
                  Text(
                    badge.message,
                    style: const TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Badge Image
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[900],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: badge.picture,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => Container(
                          height: 300,
                          color: Colors.grey[800],
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF004AAD),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 300,
                          color: Colors.grey[800],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.broken_image_outlined,
                                color: Colors.white,
                                size: 40,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Failed to load image',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Download Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: Material(
                      color: const Color(0xFF1C1C1E),
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () => controller.downloadBadge(badge.download),
                        child: Container(
                          width: 140,
                          height: 40,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Assets.icons.download.image(
                                  width: 24,
                                  height: 24
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "Download",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  if (index < controller.badges.length - 1)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Divider(color: Colors.grey, thickness: 0.5),
                    ),
                ],
              );
            },
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