// import 'package:flutter/material.dart';
// import 'package:Prommt/gen/assets.gen.dart';
// import '../../../app/routes/app_routes.dart';
// import '../../widgets/navigation_bar.dart';
// import 'package:go_router/go_router.dart';
//
// class WinnerScreen extends StatelessWidget {
//   const WinnerScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         title: const Text(
//           "Winners",
//           style: TextStyle(
//             fontFamily: 'Raleway',
//             fontWeight: FontWeight.w700,
//             fontSize: 20,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Stack(
//         children: [
//           // 🎃 Theme Name
//           Positioned(
//             left: 20,
//             child: Container(
//               width: 161,
//               height: 23,
//               decoration: BoxDecoration(
//                 color: const Color(0xFF004AAD),
//                 borderRadius: BorderRadius.circular(50),
//               ),
//               alignment: Alignment.center,
//               child: const Text(
//                 'Halloween Theme',
//                 style: TextStyle(
//                   fontFamily: 'Roboto',
//                   fontWeight: FontWeight.w500,
//                   fontSize: 16,
//                   color: Colors.white,
//                   height: 0.625,
//                 ),
//               ),
//             ),
//           ),
//
//           // 🏠 Video Title
//           const Positioned(
//             top: 50,
//             left: 20,
//             child: Text(
//               'Night House',
//               style: TextStyle(
//                 fontFamily: 'Roboto',
//                 fontWeight: FontWeight.w700,
//                 fontSize: 24,
//                 color: Colors.white,
//                 height: 0.42,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//
//           // 👤 Username
//           const Positioned(
//             top: 75,
//             left: 20,
//             child: Text(
//               '@junaid982',
//               style: TextStyle(
//                 fontFamily: 'Roboto',
//                 fontWeight: FontWeight.w700,
//                 fontSize: 14,
//                 color: Color(0xFFB0B3B8),
//                 height: 0.42,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//
//           // 🎥 Video Thumbnail (Clickable)
//           Positioned(
//             top: 105,
//             left: 20,
//             child: GestureDetector(
//               onTap: () {
//                 // 🔗 Navigate to Video Play screen
//                 GoRouter.of(context).go(Routes.videoPlay);
//               },
//               child: Container(
//                 width: 353,
//                 height: 181,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   image: DecorationImage(
//                     image: Assets.images.videoTwo.provider(),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: Center(
//                   child: Assets.icons.playIcon.image(
//                     width: 46,
//                     height: 44.64,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//
//       // 🔻 Bottom Navigation Bar
//       bottomNavigationBar: CustomNavigationBar(
//         currentIndex: 3, // Winner screen active
//         onTap: (index) {
//           switch (index) {
//             case 0:
//               GoRouter.of(context).go(Routes.home);
//               break;
//             case 1:
//               GoRouter.of(context).go(Routes.likedVideos);
//               break;
//             case 2:
//               GoRouter.of(context).go(Routes.uploadVideos);
//               break;
//             case 3:
//               GoRouter.of(context).go(Routes.winner);
//               break;
//             case 4:
//               GoRouter.of(context).go(Routes.profile);
//               break;
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Prommt/gen/assets.gen.dart';
import '../../../app/routes/app_routes.dart';
import '../../../controllers/winner_controller.dart';
import '../../widgets/navigation_bar.dart';

class WinnerScreen extends StatefulWidget {
  const WinnerScreen({super.key});

  @override
  State<WinnerScreen> createState() => _WinnerScreenState();
}

class _WinnerScreenState extends State<WinnerScreen> {
  late WinnerController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(WinnerController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Winners",
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF004AAD)),
          );
        }

        if (controller.winner.value == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'No winner announced yet',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.refreshWinner,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004AAD),
                  ),
                  child: const Text('Refresh'),
                ),
              ],
            ),
          );
        }

        final winner = controller.winner.value!;

        return RefreshIndicator(
          onRefresh: controller.refreshWinner,
          color: const Color(0xFF004AAD),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Theme Name
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF004AAD),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      winner.themeName,
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Video Title
                  Text(
                    winner.title,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Username
                  Text(
                    '@${winner.user.username}',
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xFFB0B3B8),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Video Thumbnail (Clickable)
                  GestureDetector(
                    onTap: () {
                      context.go('${Routes.videoPlay}?id=${winner.id}');
                    },
                    child: Container(
                      width: double.infinity,
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[900],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          children: [
                            // Thumbnail Image
                            Positioned.fill(
                              child: CachedNetworkImage(
                                imageUrl: winner.thumbnail,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: Colors.grey[800],
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xFF004AAD),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Container(
                                      color: Colors.grey[800],
                                      child: const Icon(
                                        Icons.error_outline,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                              ),
                            ),

                            // Play Icon
                            Center(
                              child: Assets.icons.playIcon.image(
                                width: 46,
                                height: 44.64,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: 3, // Winner screen active
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