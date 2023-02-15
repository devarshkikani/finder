import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

OutlinedButton outlinedButton({
  required String title,
  required Function()? onTap,
  Size? maximumSize,
  Color? backgroundColor,
  Color? textColor,
  Color? borderColor,
}) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
      backgroundColor: backgroundColor ?? Colors.transparent,
      maximumSize: maximumSize ?? Size(Get.width / 2, 50),
      side: BorderSide(
        color: borderColor ?? primary,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    ),
    onPressed: onTap,
    child: Center(
      child: Text(
        title,
        style: mediumText18.copyWith(
          color: textColor ?? whiteColor,
        ),
      ),
    ),
  );
}
