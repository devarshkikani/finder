import 'dart:io';

import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/user_info_screen/language_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/widget/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});
  static GetStorage box = GetStorage();
  static late UserModel userModel;
  static RxString status = ''.obs;
  static List<String> statusList = <String>[
    'Single',
    'Married',
    'Divorced',
    'Separated',
    'Widowed',
    'Divorced with kids',
    'Widowed with kids',
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
                "What's your status?",
                style: boldText34.copyWith(
                  color: primary,
                  fontFamily: 'source_serif_pro',
                ),
              ),
              height20,
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: lightBlue,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Obx(
                  () => Column(
                    children: List<Widget>.generate(
                      statusList.length,
                      (int index) => Column(
                        children: <Widget>[
                          itemWidget(statusList[index]),
                          if (index + 1 != statusList.length)
                            Container(
                              height: 0.5,
                              color: lightBlue,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              height30,
              Center(
                child: Obx(
                  () => elevatedButton(
                    title: 'Continue',
                    onTap: status.value != ''
                        ? () {
                            userModel.relationType = status.value;
                            box.write(
                              StorageKey.currentUser,
                              userModel.toJson(),
                            );
                            Get.to(() => const LanguageScreen());
                          }
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemWidget(String item) {
    return CheckboxListTile(
      value: status.value == item,
      title: Text(
        item,
        style: regularText16,
      ),
      visualDensity: VisualDensity.compact,
      activeColor: primary,
      checkboxShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      onChanged: (bool? value) {
        status.value = item;
      },
    );
  }
}
