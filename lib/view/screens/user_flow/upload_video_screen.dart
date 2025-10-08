// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:Prommt/gen/assets.gen.dart';
//
// import '../../../app/routes/app_routes.dart';
// import '../../widgets/navigation_bar.dart';
//
// class UploadVideoScreen extends StatefulWidget {
//   const UploadVideoScreen({super.key});
//
//   @override
//   State<UploadVideoScreen> createState() => _UploadVideoScreenState();
// }
//
// class _UploadVideoScreenState extends State<UploadVideoScreen> {
//   int _currentIndex = 2; // Upload tab active
//
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _themeController =
//   TextEditingController(text: "Halloween");
//
//   void _onNavTap(int index) {
//     if (_currentIndex == index) return;
//
//     setState(() {
//       _currentIndex = index;
//     });
//
//     switch (index) {
//       case 0:
//         context.go(Routes.home);
//         break;
//       case 1:
//         context.go(Routes.likedVideos);
//         break;
//       case 2:
//         context.go(Routes.uploadVideos);
//         break;
//       case 3:
//         context.go(Routes.winner);
//         break;
//       case 4:
//         GoRouter.of(context).go(Routes.profile);
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           icon: Assets.icons.cross.image(width: 30, height: 30),
//           onPressed: () {
//             GoRouter.of(context).go(Routes.home);
//           },
//         ),
//         title: const Text(
//           "Template",
//           style: TextStyle(
//             fontFamily: 'Raleway',
//             fontWeight: FontWeight.w700,
//             fontSize: 20,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // ---------- Upload Video Box ----------
//               GestureDetector(
//                 onTap: () {
//                   debugPrint("Pick video tapped");
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   height: 238,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF1C1C1E),
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Assets.icons.uploadVideo
//                           .image(width: 28, height: 28), // asset gen icon
//                       const SizedBox(height: 12),
//                       const Text(
//                         "Upload a Video",
//                         style: TextStyle(
//                           fontFamily: 'Roboto',
//                           fontWeight: FontWeight.w400,
//                           fontSize: 16,
//                           color: Color(0xFFB0B3B8),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//
//               // ---------- Upload Thumbnail Box ----------
//               GestureDetector(
//                 onTap: () {
//                   debugPrint("Pick thumbnail tapped");
//                 },
//                 child: Container(
//                   width: 160,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF1C1C1E),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Assets.icons.uploadVideo.image(width: 20, height: 20),
//                       const SizedBox(height: 8),
//                       const Text(
//                         "Upload a Cover",
//                         style: TextStyle(
//                           fontFamily: 'Roboto',
//                           fontWeight: FontWeight.w400,
//                           fontSize: 10,
//                           color: Color(0xFFB0B3B8),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 32),
//
//               // ---------- Title Input ----------
//               Row(
//                 children: [
//                   const Text(
//                     "Title",
//                     style: TextStyle(
//                       fontFamily: 'Roboto',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 18,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(width: 35),
//                   Expanded(
//                     child: TextField(
//                       controller: _titleController,
//                       style: const TextStyle(
//                           color: Colors.white, fontSize: 14, fontFamily: "Roboto"),
//                       decoration: InputDecoration(
//                         hintText: "Enter video title",
//                         hintStyle: const TextStyle(color: Color(0xFFB0B3B8)),
//                         filled: true,
//                         fillColor: const Color(0xFF1C1C1E),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide.none,
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 10),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//
//               // ---------- Theme Input ----------
//               Row(
//                 children: [
//                   const Text(
//                     "Theme",
//                     style: TextStyle(
//                       fontFamily: 'Roboto',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 18,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: TextField(
//                       controller: _themeController,
//                       readOnly: true,
//                       style: const TextStyle(color: Colors.white, fontSize: 16),
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: const Color(0xFF1C1C1E),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide.none,
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 10),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 40),
//
//               // ---------- Upload Button ----------
//               Center(
//                 child: SizedBox(
//                   width: 208,
//                   height: 43,
//                   child: ElevatedButton.icon(
//                     onPressed: () {
//                       debugPrint("Upload tapped");
//                     },
//                     icon: Assets.icons.upload.image(width: 24, height: 24),
//                     label: const Text(
//                       "Upload",
//                       style: TextStyle(
//                         fontFamily: 'Roboto',
//                         fontWeight: FontWeight.w500,
//                         fontSize: 18,
//                         color: Colors.white,
//                       ),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF004AAD),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: CustomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onNavTap,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:Prommt/gen/assets.gen.dart';
import '../../../app/routes/app_routes.dart';
import '../../../controllers/uplod_video_controller.dart';
import '../../widgets/navigation_bar.dart';

class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({super.key});

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  int _currentIndex = 2; // Upload tab active
  late UploadVideoController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(UploadVideoController());
  }

  void _onNavTap(int index) {
    if (_currentIndex == index) return;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Assets.icons.cross.image(width: 30, height: 30),
          onPressed: () {
            context.go(Routes.home);
          },
        ),
        title: const Text(
          "Upload Video",
          style: TextStyle(
            fontFamily: 'Raleway',
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

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Upload Video Box
                Obx(() => GestureDetector(
                  onTap: controller.pickVideo,
                  child: Container(
                    width: double.infinity,
                    height: 238,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1E),
                      borderRadius: BorderRadius.circular(30),
                      border: controller.hasVideoSelected.value
                          ? Border.all(color: const Color(0xFF004AAD), width: 2)
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          controller.hasVideoSelected.value
                              ? Icons.check_circle
                              : Icons.video_library,
                          color: controller.hasVideoSelected.value
                              ? const Color(0xFF004AAD)
                              : const Color(0xFFB0B3B8),
                          size: 28,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          controller.hasVideoSelected.value
                              ? "Video Selected"
                              : "Upload a Video",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: controller.hasVideoSelected.value
                                ? const Color(0xFF004AAD)
                                : const Color(0xFFB0B3B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
                const SizedBox(height: 24),

                // Upload Thumbnail Box
                Obx(() => GestureDetector(
                  onTap: controller.pickThumbnail,
                  child: Container(
                    width: 160,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1E),
                      borderRadius: BorderRadius.circular(16),
                      border: controller.hasThumbnailSelected.value
                          ? Border.all(color: const Color(0xFF004AAD), width: 2)
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          controller.hasThumbnailSelected.value
                              ? Icons.check_circle
                              : Icons.image,
                          color: controller.hasThumbnailSelected.value
                              ? const Color(0xFF004AAD)
                              : const Color(0xFFB0B3B8),
                          size: 20,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller.hasThumbnailSelected.value
                              ? "Cover Selected"
                              : "Upload a Cover",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: controller.hasThumbnailSelected.value
                                ? const Color(0xFF004AAD)
                                : const Color(0xFFB0B3B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
                const SizedBox(height: 32),

                // Title Input
                Row(
                  children: [
                    const Text(
                      "Title",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 35),
                    Expanded(
                      child: TextField(
                        controller: controller.titleController,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Roboto"),
                        decoration: InputDecoration(
                          hintText: "Enter video title",
                          hintStyle:
                          const TextStyle(color: Color(0xFFB0B3B8)),
                          filled: true,
                          fillColor: const Color(0xFF1C1C1E),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Theme Input
                Row(
                  children: [
                    const Text(
                      "Theme",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: controller.themeController,
                        readOnly: true,
                        style:
                        const TextStyle(color: Colors.white, fontSize: 16),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF1C1C1E),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Upload Button
                Center(
                  child: Obx(() => SizedBox(
                    width: 208,
                    height: 43,
                    child: ElevatedButton.icon(
                      onPressed: controller.isUploading.value
                          ? null
                          : controller.uploadVideo,
                      icon: controller.isUploading.value
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : Assets.icons.upload
                          .image(width: 24, height: 24),
                      label: Text(
                        controller.isUploading.value
                            ? "Uploading..."
                            : "Upload",
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004AAD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        disabledBackgroundColor: Colors.grey,
                      ),
                    ),
                  )),
                ),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}