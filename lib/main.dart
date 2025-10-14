import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;


import 'app/routes/app_pages.dart';
import 'controllers/contact_feedback_controller.dart';
import 'controllers/video_competetion_controller.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // 🔹 Timezone initialize
  tz.initializeTimeZones();

  // 🔹 Notification initialization
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // ✅ Device Preview bind
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContactFeedbackController()),
        ChangeNotifierProvider(create: (_) => VideoCompetitionController()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            locale: DevicePreview.locale(context), // ✅ Locale support
            builder: DevicePreview.appBuilder, // ✅ Device Preview builder bind
            title: 'Prommt',
            theme: ThemeData(primarySwatch: Colors.blue),
            routerConfig: AppPages.router,
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
//
// import 'app/routes/app_pages.dart';
// import 'controllers/contact_feedback_controller.dart';
// import 'controllers/video_competetion_controller.dart';
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//
//   // 🔹 Timezone initialize
//   tz.initializeTimeZones();
//
//   // 🔹 Notification initialization
//   const AndroidInitializationSettings initializationSettingsAndroid =
//   AndroidInitializationSettings('@mipmap/ic_launcher');
//
//   const InitializationSettings initializationSettings =
//   InitializationSettings(android: initializationSettingsAndroid);
//
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => ContactFeedbackController()),
//         ChangeNotifierProvider(create: (_) => VideoCompetitionController()),
//       ],
//       child: ScreenUtilInit(
//         designSize: const Size(375, 812),
//         minTextAdapt: true,
//         splitScreenMode: true,
//         builder: (context, child) {
//           return MaterialApp.router(
//             debugShowCheckedModeBanner: false,
//             title: 'Prommt',
//             theme: ThemeData(primarySwatch: Colors.blue),
//             routerConfig: AppPages.router,
//           );
//         },
//       ),
//     );
//   }
// }
