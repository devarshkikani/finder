import 'package:finder/splash_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'navigator');

class FinderApp extends StatelessWidget {
  const FinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Finder',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        fontFamily: 'bai_jamjuree',
        primaryColor: primary,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: primary,
          onPrimary: whiteColor,
          secondary: secondary,
          onSecondary: whiteColor,
          error: error,
          onError: error,
          background: whiteColor,
          onBackground: whiteColor,
          surface: surface,
          onSurface: surface,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
