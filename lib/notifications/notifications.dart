import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void initializeFirebase() async {
  print('Initializing Firebase');
  tz.initializeTimeZones();
  await FirebaseMessaging.instance.requestPermission();
  print(await FirebaseMessaging.instance.getToken());
  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: androidInitializationSettings);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
      print('Notification clicked: ${notificationResponse.payload}');
    },
    onDidReceiveBackgroundNotificationResponse:
        notificationTapBackgroundHandler,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.notification!.body}');
    print('Message title: ${message.notification!.title}');

    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
        0,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel_id',
            'channel_name',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
      );
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle background notifications
}

Future<void> scheduleNotification(
    String title, String body, DateTime scheduledTime) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channel_id', // Channel ID
    'channel_name', // Channel Name
    channelDescription: 'Description of the channel', // Optional
    importance: Importance.high,
    priority: Priority.high,
  );

  const NotificationDetails platformDetails =
      NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0, // Notification ID
    title, // Notification Title
    body, // Notification Body
    tz.TZDateTime.from(scheduledTime, tz.local), // Scheduled Time
    platformDetails, // Notification Details
    androidScheduleMode:
        AndroidScheduleMode.exactAllowWhileIdle, // Android Schedule Mode
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents:
        DateTimeComponents.time, // Optional, useful for recurring notifications
  );
}
