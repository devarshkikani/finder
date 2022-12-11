import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

ElevatedButton elevatedButton({
  required String title,
  required Function()? onTap,
  Size? maximumSize,
  Color? backgroundColor,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? primary,
      maximumSize: maximumSize ?? Size(Get.width / 2, 50),
      disabledBackgroundColor: lightBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    onPressed: onTap,
    child: Center(
      child: Text(
        title,
        style: mediumText16.copyWith(
          color: whiteColor,
        ),
      ),
    ),
  );
}
