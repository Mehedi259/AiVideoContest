import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:Prommt/gen/assets.gen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../app/routes/app_routes.dart';
import '../../../main.dart';
import '../../widgets/navigation_bar.dart';
import '../../widgets/custom_drawer.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  // 🔹 Screen notification list
  List<String> notifications = [];

  @override
  void initState() {
    super.initState();
    _scheduleDailyNotification();
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

  // 🔹 Add notification to screen
  void _addNotificationToScreen(String message) {
    setState(() {
      notifications.insert(0, message); // newest on top
    });
  }

  // 🔹 Schedule daily notification
  Future<void> _scheduleDailyNotification() async {
    const notificationMessage =
        "Your vote is now available, so you can cast it.";

    // Add immediately to screen for first run
    _addNotificationToScreen(notificationMessage);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Daily Reminder',
      notificationMessage,
      tz.TZDateTime.now(tz.local).add(const Duration(hours: 24)), // 24h from now
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_channel_id',
          'Daily Notifications',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time, // repeat daily
    );
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
            // 🔹 Top AppBar
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
                        "Notification",
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

            // 🔹 Scrollable notifications
            Expanded(
              child: notifications.isEmpty
                  ? const Center(
                child: Text(
                  "No notifications yet",
                  style: TextStyle(color: Colors.white),
                ),
              )
                  : SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  children: List.generate(notifications.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            Assets.icons.notification.image(
                                width: 16, height: 16),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notifications[index],
                                    style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      height: 1.64,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "${TimeOfDay.now().format(context)}",
                                    style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      height: 1.9,
                                      color: Color(0xFFB0B3B8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    );
                  }),
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
}
