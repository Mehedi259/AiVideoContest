import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'app/routes/app_pages.dart';
import 'controllers/contact_feedback_controller.dart';
import 'controllers/video_competetion_controller.dart';
import 'data/services/admob_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // System UI
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // Timezone init
  tz.initializeTimeZones();

  // ✅ Initialize AdMob
  await AdMobHelper.initialize();

  // 🔔 Notification initialization (ANDROID + IOS)
  const androidSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const iosSettings = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const initializationSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ContactFeedbackController(),
        ),
        ChangeNotifierProvider(
          create: (_) => VideoCompetitionController(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Prommt',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routerConfig: AppPages.router,
          );
        },
      ),
    );
  }
}