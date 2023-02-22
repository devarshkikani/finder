import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

GestureDetector elevatedButton({
  required String title,
  required Function()? onTap,
  Size? maximumSize,
  Color? backgroundColor,
  Color? textColor,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: maximumSize == null ? 50 : maximumSize.height,
      width: maximumSize == null ? (Get.width / 2) : maximumSize.width,
      decoration: BoxDecoration(
        color: backgroundColor ?? lightBlack,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: <BoxShadow>[
          const BoxShadow(
            color: blackColor,
            offset: Offset(5, 5),
            blurRadius: 15,
            spreadRadius: 5,
          ),
          BoxShadow(
            color: Colors.grey.shade800,
            offset: const Offset(-4, -4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Text(
          title,
          style: mediumText18.copyWith(
            color: textColor ?? whiteColor,
          ),
        ),
      ),
    ),
  );
}
