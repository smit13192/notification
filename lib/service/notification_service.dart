import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification/core/router/routes.dart';
import 'package:notification/util/log.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// handle background notification
Future<void> handleBackground(RemoteMessage message) async {
  Log.d('Title:- ${message.notification?.title}');
  Log.d('Body:- ${message.notification?.body}');
  Log.d('Data:- ${message.data}');
}

/// [NotificationService] use for handle firebase notification using flutter local notification
class NotificationService {
  NotificationService._();

  static final _instance = NotificationService._();

  factory NotificationService() {
    return _instance;
  }

  final _firebaseMessaging = FirebaseMessaging.instance;

  final _flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Important Notification',
    description: 'This channel is use for important notification',
    importance: Importance.high,
  );
  final icon = '@drawable/ic_launcher';

  Future<void> init() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    Log.d('FCM TOKEN:- $fcmToken');
    await initPushNotification();
    await initLocalNotification();
  }

  Future<void> initPushNotification() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    _firebaseMessaging.getInitialMessage().then(handleMessage);
    _firebaseMessaging.setAutoInitEnabled(true);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackground);
    FirebaseMessaging.onMessage.listen((event) {
      final notification = event.notification;
      if (notification == null) return;
      showNotification(
        title: notification.title!,
        body: notification.body!,
        paylod: notification.toMap(),
      );
    });
  }

  Future<void> initLocalNotification() async {
    const iosInitializationSettings = DarwinInitializationSettings();
    final androidInitializationSettings = AndroidInitializationSettings(icon);

    final settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveNotificationResponse,
    );

    final androidPlartformImplementation =
        _flutterLocalNotificationPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    androidPlartformImplementation?.createNotificationChannel(_androidChannel);
    final iosPlartformImplementation =
        _flutterLocalNotificationPlugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
    iosPlartformImplementation?.requestPermissions(
      alert: true,
      sound: true,
      badge: true,
    );
  }

  void showNotification({
    required String title,
    required String body,
    required Map<String, dynamic> paylod,
  }) {
    final id = Random().nextInt(1000);
    final notificationDetails = getNotificationDetails();
    _flutterLocalNotificationPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: jsonEncode(paylod),
    );
  }

  NotificationDetails getNotificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        _androidChannel.id,
        _androidChannel.name,
        channelDescription: _androidChannel.description,
        icon: icon,
        importance: _androidChannel.importance,
      ),
    );
  }

  void handleMessage(RemoteMessage? message) async {
    if (message == null) return;
    navigatorKey.currentState?.pushNamed(Routes.notification);
  }
}

void onDidReceiveNotificationResponse(NotificationResponse details) {
  navigatorKey.currentState?.pushNamed(Routes.notification);
}
