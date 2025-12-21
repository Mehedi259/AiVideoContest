import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:Prommt/view/widgets/custom_video_card.dart';
import 'package:Prommt/view/widgets/custom_drawer.dart';
import 'package:Prommt/view/widgets/navigation_bar.dart';
import 'package:Prommt/gen/assets.gen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../app/routes/app_routes.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/services/admob_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeController controller = Get.put(HomeController());
  int _currentIndex = 0;

  // ✅ Banner Ad Variables
  BannerAd? _bannerAd;
  bool _isBannerAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  // ✅ Load Banner Ad
  void _loadBannerAd() {
    _bannerAd = AdMobHelper.createBannerAd(
      onAdLoaded: (ad) {
        setState(() {
          _isBannerAdLoaded = true;
        });
        print('✅ Banner Ad Loaded');
      },
      onAdFailedToLoad: (ad, error) {
        print('❌ Banner Ad Failed to Load: $error');
        ad.dispose();
      },
    );
    _bannerAd?.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
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
        GoRouter.of(context).go(Routes.uploadVideos);
        break;
      case 3:
        GoRouter.of(context).go(Routes.winner);
        break;
      case 4:
        GoRouter.of(context).go(Routes.profile);
        break;
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
            // 🔹 Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    child: const Icon(Icons.menu, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Text(
                      "Theme Competition",
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      IconButton(
                        onPressed: () {
                          GoRouter.of(context).go(Routes.notification);
                        },
                        icon: Assets.icons.notification.image(width: 22, height: 22),
                      ),
                      Positioned(
                        right: 14,
                        top: 10,
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                            color: Color(0xFF004AAD),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ✅ Banner Ad Section
            if (_isBannerAdLoaded && _bannerAd != null)
              Container(
                alignment: Alignment.center,
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),

            const SizedBox(height: 10),

            // 🔹 Theme name
            Obx(() {
              if (controller.themeName.value != null) {
                return Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 23,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: const Color(0xFF004AAD), width: 1),
                    ),
                    child: Center(
                      child: Text(
                        controller.themeName.value!,
                        style: const TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),

            const SizedBox(height: 15),

            // 🔹 Video List Section
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF004AAD)),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await controller.loadVideos();
                    await controller.loadLeaderboard();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        // 🔹 Rounded Cover Image with BoxFit.cover
                        Obx(() {
                          if (controller.themeCoverImage.value != null) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                controller.themeCoverImage.value!,
                                width: double.infinity,
                                height: 124.77,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: double.infinity,
                                    height: 124.77,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey[900],
                                    ),
                                    child: const Icon(Icons.image, color: Colors.grey),
                                  );
                                },
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }),

                        const SizedBox(height: 15),

                        // 🔹 Toggle buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 15),
                            _buildToggleButton("All Videos", !controller.showTop3.value),
                            const SizedBox(width: 10),
                            _buildToggleButton("Top 3 Videos", controller.showTop3.value),
                          ],
                        ),

                        const SizedBox(height: 15),

                        // 🔹 Video Cards
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Wrap(
                            spacing: 15,
                            runSpacing: 15,
                            children: (controller.showTop3.value
                                ? controller.top3Videos
                                : controller.videos)
                                .asMap()
                                .entries
                                .map((entry) {
                              final index = entry.key;
                              final video = entry.value;

                              String? rank;
                              if (controller.showTop3.value && index < 3) {
                                rank = 'Top ${index + 1}';
                              }

                              return CustomVideoCard(
                                imagePath: video.thumbnail,
                                title: video.title,
                                user: '@${video.user.username}',
                                views: '${video.views} views',
                                rank: rank,
                                onTap: () async {
                                  GoRouter.of(context)
                                      .go('${Routes.videoPlay}?id=${video.id}');
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              }),
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

  Widget _buildToggleButton(String text, bool active) {
    return GestureDetector(
      onTap: () {
        controller.toggleView();
      },
      child: Container(
        width: text == "All Videos" ? 104 : 116,
        height: 30,
        decoration: BoxDecoration(
          color: active ? const Color(0xFF004AAD) : const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(50),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: active ? FontWeight.w500 : FontWeight.w400,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}