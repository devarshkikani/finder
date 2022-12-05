// ignore_for_file: always_specify_types

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/screens/authentication/welcome_screen.dart';
import 'package:finder/constant/default_images.dart';
import 'package:finder/screens/home/main_home_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GetStorage box = GetStorage();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: AnimatedSplashScreen(
        splashIconSize: 250,
        duration: 1000,
        pageTransitionType: PageTransitionType.fade,
        splash: Image.asset(
          appLogo,
        ),
        nextScreen: box.read(StorageKey.isLogedIn) == true
            ? MainHomeScreen()
            : const WelcomeScreen(),
      ),
    );
  }
}
