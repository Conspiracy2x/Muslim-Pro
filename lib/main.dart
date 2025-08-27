import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:muslim_pro/service/hadith_service.dart';
import 'package:muslim_pro/pages/timer_notifier.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:workmanager/workmanager.dart';

import 'pages/bottom.dart';
import 'firebase_options.dart';
import 'pages/theme_provider.dart';
import 'utils/theme.dart';
import 'utils/tim.dart';

// Check and request all required permissions
Future<bool> requestPermissions() async {
  // Request notification permission
  final notificationStatus = await Permission.notification.request();

  // Request exact alarms permission for Android 12 and above
  final alarmStatus = await Permission.scheduleExactAlarm.request();

  // For Android 13+, we'll check if notifications are enabled
  if (Platform.isAndroid) {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt >= 33) {
      final areNotificationsEnabled = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      if (!areNotificationsEnabled) {
        // Open app settings if notifications are not enabled
        await openAppSettings();
      }
    }
  }

  print('Notification permission: $notificationStatus');
  print('Exact alarm permission: $alarmStatus');

  // Return true if both permissions are granted
  return notificationStatus.isGranted && alarmStatus.isGranted;
}

Future<Map<String, String>> fetchPrayerTimes(
    String city, String country) async {
  print("called");
  final url =
      'https://api.aladhan.com/v1/timingsByCity?city=$city&country=$country';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final timings = Map<String, dynamic>.from(
        json.decode(response.body)['data']['timings']);
    final convertedTimings =
        timings.map<String, String>((String key, dynamic value) {
      return MapEntry(key, convertTo12HourFormat(value.toString()));
    });
    return convertedTimings;
  } else {
    throw Exception('Failed to load prayer times');
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Initialize notifications
Future<void> initializeNotifications() async {
  tz.initializeTimeZones();
  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
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
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
      // Handle notification tap
      print('Notification tapped: ${notificationResponse.payload}');
    },
    onDidReceiveBackgroundNotificationResponse:
        notificationTapBackgroundHandler,
  );
}

Future<void> scheduleNotification(
  String title,
  String body,
  DateTime scheduledTime,
) async {
  try {
    tz.initializeTimeZones();
    const androidDetails = AndroidNotificationDetails(
      'prayer_reminder_channel',
      'Prayer Reminders',
      channelDescription: 'Notifications for prayer times',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final notificationDetails = const NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Convert DateTime to TZDateTime
    final scheduledDate = tz.TZDateTime.from(scheduledTime, tz.local);

    if (scheduledDate.isBefore(tz.TZDateTime.now(tz.local))) {
      print('Error: Scheduled date must be in the future.');
    } else {
      print('Scheduled notification at: $scheduledDate');
      // Schedule the notification here
      await flutterLocalNotificationsPlugin.zonedSchedule(
        DateTime.now().millisecond, // Unique ID for each notification
        title,
        body,
        scheduledDate,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      print('Notification scheduled for $scheduledDate');
    }
  } catch (e) {
    print('Error scheduling notification: $e');
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      await initializeNotifications();

      // Fetch prayer times
      final timings = await fetchPrayerTimes('London', 'UK');

      // Schedule notifications for each prayer
      for (var entry in timings.entries) {
        final prayerTime = parseTimeToDateTime(entry.value);
        await scheduleNotification(
            entry.key, 'It\'s time for ${entry.key}', prayerTime);
      }

      return Future.value(true);
    } catch (error) {
      print('Error in callbackDispatcher: $error');
      return Future.value(false);
    }
  });
}

// void initializeBackgroundSync() {
//   Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
//   Workmanager().registerPeriodicTask(
//     'show_test_notification',
//     'show_test_notification',
//     frequency: const Duration(minutes: 15), // Minimum allowed by Android
//   );
// }

// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     try {
//       await initializeNotifications(); // Initialize notifications in background
//
//       final timings = await fetchPrayerTimes("Karachi", "Pakistan");
//       print('Fetched prayer times: $timings');
//
//       for (var entry in timings.entries) {
//         final prayer = entry.key;
//         final time = entry.value;
//         final notificationTime = parseTimeToDateTime(time);
//
//         if (notificationTime.isAfter(DateTime.now())) {
//           await scheduleNotification(
//             '$prayer Prayer Time',
//             'It\'s time for $prayer prayer',
//             notificationTime,
//           );
//           print('Scheduled notification for $prayer at $notificationTime');
//         }
//       }
//
//       return Future.value(true);
//     } catch (error) {
//       print('Error in callbackDispatcher: $error');
//       return Future.value(false);
//     }
//   });
// }

@pragma('vm:entry-point')
void notificationTapBackgroundHandler(
    NotificationResponse notificationResponse) {
  print('Notification tapped with payload: ${notificationResponse.payload}');
}

// Future<void> testNotification() async {
//   await scheduleNotification(
//     'Test Notification',
//     'This is a test notification',
//     DateTime.now().add(const Duration(seconds: 10)),
//   );
//   print('Test notification scheduled');
// }

void initializeBackgroundSync() {
  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  Workmanager().registerPeriodicTask(
    'fetch_prayer_times',
    'fetch_prayer_times',
    frequency: const Duration(minutes: 15),
  );
  print('Background sync initialized');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final permissionsGranted = await requestPermissions();
  if (!permissionsGranted) {
    print('Required permissions not granted');
    // You might want to show a dialog to the user here
  }

  // Initialize timezone and notifications
  tz.initializeTimeZones();
  await initializeNotifications();

  // For immediate testing, schedule the first notification
  // Future.delayed(const Duration(seconds: 10), () async {
  //   await scheduleTestNotification();
  // });

  // Start periodic background task
  initializeBackgroundSync();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => HadithService()),
        ChangeNotifierProvider(create: (context) => TimerNotifier()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 850),
        minTextAdapt: true,
        builder: (context, _) {
          return Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode: themeProvider.themeMode,
                // Use the provider's ThemeMode
                darkTheme: AppTheme.darkTheme,
                theme: AppTheme.lightTheme,
                // Default light theme
                title: 'Muslim Pro',
                home: const BottomNavBarPage(),
              );
            },
          );
        },
      ),
    );
  }
}
