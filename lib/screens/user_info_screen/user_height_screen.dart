import 'dart:io';

import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserHeightScreen extends StatefulWidget {
  const UserHeightScreen({super.key});

  @override
  State<UserHeightScreen> createState() => _UserHeightScreenState();
}

class _UserHeightScreenState extends State<UserHeightScreen> {
  static RxString height = "3'1''".obs;
  static GetStorage box = GetStorage();
  static late UserModel userModel;
  static List<String> heightList = <String>[
    "3'1''",
    "3'2''",
    "3'3''",
    "3'4''",
    "3'5''",
    "3'6''",
    "3'7''",
    "3'8''",
    "3'9''",
    "3'10''",
    "3'11''",
    "3'12''",
    "4'1''",
    "4'2''",
    "4'3''",
    "4'4''",
    "4'5''",
    "4'6''",
    "4'7''",
    "4'8''",
    "4'9''",
    "4'10''",
    "4'11''",
    "4'12''",
    "5'1''",
    "5'2''",
    "5'3''",
    "5'4''",
    "5'5''",
    "5'6''",
    "5'7''",
    "5'8''",
    "5'9''",
    "5'10''",
    "5'11''",
    "5'12''",
    "6'1''",
    "6'2''",
    "6'3''",
    "6'4''",
    "6'5''",
    "6'6''",
    "6'7''",
    "6'8''",
    "6'9''",
    "6'10''",
    "6'11''",
    "6'12''",
    "7'1''",
    "7'2''",
    "7'3''",
    "7'4''",
    "7'5''",
    "7'6''",
    "7'7''",
    "7'8''",
    "7'9''",
    "7'10''",
    "7'11''",
    "7'12''",
  ];
  @override
  Widget build(BuildContext context) {
    userModel = UserModel.fromJson(
        box.read(StorageKey.currentUser) as Map<String, dynamic>);
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
                'How tall are you?',
                style: boldText34.copyWith(
                  color: primary,
                  fontFamily: 'source_serif_pro',
                ),
              ),
              height20,
              SizedBox(
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 40,
                        magnification: 1.33,
                        squeeze: 1.2,
                        useMagnifier: true,
                        looping: false,
                        onSelectedItemChanged: (int value) {
                          height.value = heightList[value];
                        },
                        children: List<Widget>.generate(
                          heightList.length,
                          (int index) => Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              heightList[index],
                              style: mediumText18.copyWith(
                                color: blackColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                    onPressed: height.value != ''
                        ? () {
                            userModel.height = height.value;
                            box.write(
                              StorageKey.currentUser,
                              userModel.toJson(),
                            );
                          }
                        : null,
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
