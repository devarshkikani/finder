// ignore_for_file: always_specify_types

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/authentication/welcome/welcome_screen.dart';
import 'package:finder/screens/main_home/main_home_screen.dart';
import 'package:finder/screens/user_info_screen/name_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/constant/default_images.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
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
    const InitializationSettings initSetttings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      log('${message?.notification?.title}+++++');
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
      log('${message?.notification?.title}-----');

      if (Platform.isIOS) {
        onSelectNotification(json.encode(message!.data));
      } else {
        onSelectNotification(json.encode(message!.data));
      }
    });
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    log('Handling a background message ${message.notification?.title}');
  }

  Future showNotification(String title, String message, dynamic payload) async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'channel id',
      'channel NAME',
      channelDescription: 'CHANNEL DESCRIPTION',
      priority: Priority.high,
      importance: Importance.max,
      playSound: true,
    );

    const iOS = IOSNotificationDetails();

    const platform = NotificationDetails(iOS: iOS, android: android);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      message,
      platform,
      // payload: payload,
    );
  }

  Future onSelectNotification(String? payloadData) async {
    final dynamic payload = await json.decode(payloadData ?? '');
    log(payload.toString());
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
