// ignore_for_file: always_specify_types

import 'dart:convert';
import 'dart:io';

import 'package:finder/constant/app_endpoints.dart';
import 'package:finder/utils/network_dio.dart';
import 'package:flutter/material.dart';
import 'package:finder/theme/colors.dart';
import 'package:get_storage/get_storage.dart';
import 'package:finder/models/user_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/constant/default_images.dart';
import 'package:page_transition/page_transition.dart';
import 'package:finder/constant/global_singleton.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:finder/screens/main_home/main_home_screen.dart';
import 'package:finder/screens/user_info_screen/name_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:finder/screens/authentication/welcome/welcome_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  GetStorage box = GetStorage();
  late UserModel currentUser;

  @override
  void initState() {
    super.initState();
    if (box.read(StorageKey.currentUser) != null) {
      currentUser = UserModel.fromJson(
          box.read(StorageKey.currentUser) as Map<String, dynamic>);
    }
    firebaseNotificationSetup();
  }

  Future<void> firebaseNotificationSetup() async {
    await Firebase.initializeApp();
    await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    final String? token = await messaging.getToken();

    GlobalSingleton().deviceToken = token.toString();
    const InitializationSettings initSetttings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );

    flutterLocalNotificationsPlugin.initialize(
      initSetttings,
      // onDidReceiveNotificationResponse: onSelectNotification,
      // onDidReceiveBackgroundNotificationResponse: onSelectNotification,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      if (Platform.isIOS) {
        await showNotification(
          message!.notification!.title.toString(),
          message.notification!.body.toString(),
          json.encode(message.data),
        );
      }
      if (Platform.isAndroid) {
        final String? title = message!.notification?.title;
        final String? body = message.notification?.body;
        if (title != null && body != null) {
          await showNotification(
            title,
            body,
            json.encode(message.data),
          );
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      if (Platform.isIOS) {
        onSelectNotification(json.encode(message!.data));
      } else {
        onSelectNotification(json.encode(message!.data));
      }
    });
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    updateUserStatus(isActive: true);
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {}

  Future showNotification(String title, String message, dynamic payload) async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'channel id',
      'channel NAME',
      channelDescription: 'CHANNEL DESCRIPTION',
      priority: Priority.high,
      importance: Importance.max,
      enableVibration: true,
      fullScreenIntent: true,
      playSound: true,
    );

    const iOS = DarwinNotificationDetails();

    const platform = NotificationDetails(iOS: iOS, android: android);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      message,
      platform,
      // payload: payload,
    );
  }

  Future onSelectNotification(String? payloadData) async {}

  Future<void> updateUserStatus({required bool isActive}) async {
    final Map<String, dynamic>? resposnse = await NetworkDio.getDioHttpMethod(
      url:
          '''${ApiEndPoints.apiEndPoint}${ApiEndPoints.updateUserStatus}$isActive''',
    );
    if (resposnse != null) {
      currentUser.isActive = isActive;
      box.write(StorageKey.currentUser, currentUser.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlack,
      body: AnimatedSplashScreen(
        splashIconSize: 250,
        duration: 1000,
        pageTransitionType: PageTransitionType.fade,
        splash: Image.asset(
          appLogoTransparent,
        ),
        nextScreen: box.read(StorageKey.isLogedIn) == true
            ? currentUser.isProfileCompleted
                ? MainHomeScreen()
                : NameScreen()
            : const WelcomeScreen(),
      ),
    );
  }
}
