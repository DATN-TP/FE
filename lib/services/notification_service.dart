import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotification {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,

    );
    final fCMToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fCMToken');

  }

  static Future localNotiInit() async {
      const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
      final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings();
      final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsDarwin);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

  }

}