
import 'package:ResiEasy/data/hive/hive_provider.dart';
import 'package:ResiEasy/views/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import './views/pages/login/login.dart';
import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  _showNotification(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  requestNotificationPermissions();

  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Message data tin nhan: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      _showNotification(message);
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final fcmToken = await FirebaseMessaging.instance.getToken();




  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<Map<dynamic, dynamic>>(HiveProvider.HIVE_BIOMETRIC_BOX);
  await Hive.openBox<String>(HiveProvider.HIVE_USER_BOX);
  await dotenv.load(fileName: ".env");

  final hiveProvider = HiveProvider();
  hiveProvider.saveFCMToken(fcmToken!);
    print('FCM Token: $fcmToken');

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
      final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
      // Handle the notification tapped logic here
    },
  );

  final InitializationSettings initializationSettings =
       InitializationSettings(
    android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS, 

  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('vi', 'VN'),
      ],
      path: 'assets/translations',
      child: const MyApp(),
    ),
  );
}

Future<void> requestNotificationPermissions() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

Future<void> _showNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      channelDescription: 'your_channel_description',
    );
  const DarwinNotificationDetails iOSPlatformChannelSpecifics =
      DarwinNotificationDetails();

  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title,
    message.notification?.body,
    platformChannelSpecifics,
    payload: 'item x',
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: '/',
      onGenerateRoute: Routes.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const Login(),
    );
  }
}