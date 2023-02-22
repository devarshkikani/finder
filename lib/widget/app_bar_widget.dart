import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finder/constant/sizedbox.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';

AppBar appbarWidget({
  String? title,
  Function()? onTap,
  bool? centerTitle,
  Color? backgroundColor,
}) {
  return AppBar(
    backgroundColor: backgroundColor ?? lightBlack,
    elevation: 0,
    leading: IconButton(
      onPressed: onTap ??
          () {
            Get.back();
          },
      icon: Icon(
        Platform.isAndroid
            ? Icons.arrow_back_rounded
            : Icons.arrow_back_ios_rounded,
        color: whiteColor,
      ),
    ),
    centerTitle: centerTitle ?? true,
    title: title != null
        ? Text(
            title,
            style: regularText20,
          )
        : null,
  );
}

AppBar appBarWithAction({
  Function()? onTap,
  bool? centerTitle,
  Color? backgroundColor,
}) {
  return AppBar(
    leading: IconButton(
      onPressed: onTap ??
          () {
            Get.back();
          },
      icon: Icon(
        Platform.isAndroid
            ? Icons.arrow_back_rounded
            : Icons.arrow_back_ios_rounded,
      ),
    ),
    centerTitle: true,
    elevation: 0,
    title: const Text(
      'MyCartExpress',
    ),
    actions: <Widget>[
      GestureDetector(
        onTap: () {
          // Get.to(() => const MessagesScreen());
        },
        child: const Icon(
          Icons.mail_outline_rounded,
        ),
      ),
      width15,
      GestureDetector(
        onTap: () {
          // Get.to(() => const NotificationScreen());
        },
        child: const Icon(
          Icons.notifications_active_outlined,
        ),
      ),
      width15,
    ],
  );
}
