// ignore_for_file: must_be_immutable

import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/user_info_screen/religion_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/widget/app_bar_widget.dart';
import 'package:finder/widget/show_banner_ads.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserHeightScreen extends StatelessWidget {
  UserHeightScreen({
    super.key,
    required this.isEdit,
  });

  RxBool isEdit = false.obs;

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
      backgroundColor: lightBlack,
      appBar: appbarWidget(),
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List<Widget>.generate(
                      heightList.length,
                      (int index) => InkWell(
                        onTap: () {
                          userModel.height = heightList[index];
                          box.write(
                            StorageKey.currentUser,
                            userModel.toJson(),
                          );
                          if (isEdit.value) {
                            Get.back(result: true);
                          } else {
                            Get.to(() => ReligionScreen(
                                  isEdit: false.obs,
                                ));
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Text(
                                heightList[index],
                                style: mediumText20.copyWith(
                                  color: whiteColor,
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
      bottomNavigationBar: const ShowBannerAds(),
    );
  }
}
