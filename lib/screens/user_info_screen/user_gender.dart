import 'dart:io';

import 'package:finder/constant/sizedbox.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserGender extends StatelessWidget {
  const UserGender({super.key});

  static RxString gender = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Platform.isIOS
                ? Icons.arrow_back_ios_new_rounded
                : Icons.arrow_back_rounded,
            color: blackColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "What's your gender?",
                style: boldText34.copyWith(
                  color: primary,
                  fontFamily: 'source_serif_pro',
                ),
              ),
              height20,
              Container(
                decoration: BoxDecoration(
                  color: darkGrey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Obx(
                  () => Column(
                    children: <Widget>[
                      CheckboxListTile(
                        value: gender.value == 'Male',
                        title: Text(
                          'Male',
                          style: regularText16,
                        ),
                        activeColor: primary,
                        checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        onChanged: (bool? value) {
                          gender.value = 'Male';
                        },
                      ),
                      Container(
                        height: 0.5,
                        color: darkGrey,
                      ),
                      CheckboxListTile(
                        value: gender.value == 'Female',
                        title: Text(
                          'Female',
                          style: regularText16,
                        ),
                        activeColor: primary,
                        checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        onChanged: (bool? value) {
                          gender.value = 'Female';
                        },
                      ),
                      Container(
                        height: 0.5,
                        color: darkGrey,
                      ),
                      CheckboxListTile(
                        value: gender.value == 'Other',
                        title: Text(
                          'Other',
                          style: regularText16,
                        ),
                        visualDensity: VisualDensity.compact,
                        activeColor: primary,
                        checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        onChanged: (bool? value) {
                          gender.value = 'Other';
                        },
                      ),
                    ],
                  ),
                ),
              ),
              height20,
              Center(
                child: Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      maximumSize: Size(Get.width / 2, 50),
                      disabledBackgroundColor: darkGrey,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    onPressed: gender.value != '' ? () {} : null,
                    child: Center(
                      child: Text(
                        'Continue',
                        style: mediumText16.copyWith(
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
