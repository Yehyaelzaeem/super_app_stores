import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../domain/logger.dart';
import 'NotificationType.dart';
import 'NotificationUtils.dart';
import 'push_notification_model.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'Used for important notifications',
  importance: Importance.high,
);

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('FcmHandler', 'Background FCM: ${message.data}');
}

class FcmHandler extends StatefulWidget {
  final Widget _child;
  final GlobalKey<NavigatorState> _navigatorKey;

  const FcmHandler({
    Key? key,
    required Widget child,
    required GlobalKey<NavigatorState> navigatorKey,
  })  : _child = child,
        _navigatorKey = navigatorKey,
        super(key: key);

  @override
  _FcmHandlerState createState() => _FcmHandlerState();
}

class _FcmHandlerState extends State<FcmHandler> {
  static const _tag = 'FcmHandler';
  static bool initialized = false;

  @override
  void initState() {
    super.initState();
    if (!initialized) initializeFcm();
  }

  @override
  Widget build(BuildContext context) {
    return widget._child;
  }

  Future<void> initializeFcm() async {
    if (initialized) return;

    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // طلب الإذن (مهم لأندرويد 13+ و iOS)
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // إعداد الـ notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings();

    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        if (details.payload != null) {
          setupNotificationClickAction(details.payload!, widget._navigatorKey);
        }
      },
    );

    // إنشاء قناة للأندرويد
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // عرض الإشعار عند فتح التطبيق من الإشعار
    final RemoteMessage? remoteMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      setupNotificationClickAction(
          json.encode(remoteMessage.data), widget._navigatorKey);
    }

    log(_tag, "Requesting FCM token...");
    _getToken();

    // لو الإشعار وصل والتطبيق في Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log(_tag,
          'Foreground FCM: ${message.data}\nTitle: ${message.notification?.title}\nBody: ${message.notification?.body}');

      StyleInformation? styleInformation;

      // لو فيه صورة
      final imageUrl = message.notification?.android?.imageUrl ??
          message.notification?.apple?.imageUrl;

      if (imageUrl != null) {
        final bigPicturePath =
        await NotificationUtils.downloadAndSaveImage(imageUrl, "image");
        styleInformation = BigPictureStyleInformation(
          FilePathAndroidBitmap(bigPicturePath),
          contentTitle: message.notification?.title,
          summaryText: message.notification?.body,
        );
      } else {
        styleInformation = BigTextStyleInformation(
          message.notification?.body ?? '',
        );
      }

      final notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: 'High importance notifications',
          importance: Importance.high,
          priority: Priority.high,
          styleInformation: styleInformation,
        ),
        iOS: const DarwinNotificationDetails(),
      );

      await flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title ?? '',
        message.notification?.body ?? '',
        notificationDetails,
        payload: json.encode(message.data),
      );
    });

    // لو التطبيق مفتوح من الإشعار
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log(_tag, 'App opened from FCM: ${message.data}');
      setupNotificationClickAction(
          json.encode(message.data), widget._navigatorKey);
    });

    initialized = true;
  }

  void _getToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      log(_tag, "FCM token: $token");
      // send token to your server if needed
    } catch (e) {
      log(_tag, "FCM token error: $e");
    }
  }

  static void setupNotificationClickAction(
      String payload, GlobalKey<NavigatorState>? navigatorKey) {
    log(_tag, 'Notification payload: $payload');
    try {
      FCMNotificationModel model = notificationModelFromJson(payload);
      if (model != null) {
        NotificationHelper.notificationNav(model, navigatorKey: navigatorKey);
      }
    } catch (e) {
      log(_tag, 'Error parsing notification payload: $e');
    }
  }
}
