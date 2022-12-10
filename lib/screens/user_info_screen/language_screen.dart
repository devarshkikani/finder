import 'dart:io';

import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/user_info_screen/status_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  static GetStorage box = GetStorage();
  static late UserModel userModel;
  static List<String> tongueList = <String>[
    'Chinese',
    'Arabic',
    'Hindi',
    'Spanish',
    'English',
    'Bengali',
    'Portugese',
    'Landha',
    'Russian',
    'Japanese',
    'Javanese',
    'Korean',
    'German',
    'French',
    'Telagu',
    'Marathi',
    'Turkish',
    'Urdu',
    'Tamil',
    'Vietnamese',
    'Italian',
    'Malay bahasa',
    'Persian',
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
                "What's your mother tongue?",
                style: boldText34.copyWith(
                  color: primary,
                  fontFamily: 'source_serif_pro',
                ),
              ),
              height20,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List<Widget>.generate(
                      tongueList.length,
                      (int index) => InkWell(
                        onTap: () {
                          userModel.languageSpoken = tongueList[index];
                          box.write(
                            StorageKey.currentUser,
                            userModel.toJson(),
                          );
                          Get.to(() => const StatusScreen());
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Text(
                                tongueList[index],
                                style: mediumText20.copyWith(
                                  color: blackColor,
                                ),
                              ),
                            ),
                            Container(
                              height: 0.5,
                              color: darkGrey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              height20,
            ],
          ),
        ),
      ),
    );
  }
}
