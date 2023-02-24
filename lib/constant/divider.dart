import 'package:finder/theme/colors.dart';
import 'package:flutter/material.dart';

Widget dividers(double? margin, {Color? color}) {
  return Container(
    height: 1,
    color: color ?? darkGrey,
    margin: margin != null
        ? EdgeInsets.symmetric(
            vertical: margin,
          )
        : null,
  );
}
