import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';  // Device Preview import
import 'app/routes/app_pages.dart';

void main() {
  // Ensure screen util is initialized
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    DevicePreview(
      enabled: !GetPlatform.isMobile, // Enable only for web or desktop for preview
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsive design
    ScreenUtil.init(
      context,
      designSize: Size(375, 812), // Set the base screen size (iPhone X design size)
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trope',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      builder: DevicePreview.appBuilder, // Add device preview builder
    );
  }
}
