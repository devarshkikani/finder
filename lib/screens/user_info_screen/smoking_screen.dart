import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/user_info_screen/drugs_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/widget/app_bar_widget.dart';
import 'package:finder/widget/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SmokingScreen extends StatelessWidget {
  const SmokingScreen({super.key});

  static RxString areYouSmoking = ''.obs;
  static GetStorage box = GetStorage();
  static late UserModel userModel;
  static List<String> smokingList = <String>[
    'Yes',
    'Sometimes',
    'Never',
    'Prefer not to say',
  ];

  @override
  Widget build(BuildContext context) {
    userModel = UserModel.fromJson(
        box.read(StorageKey.currentUser) as Map<String, dynamic>);
    return Scaffold(
      appBar: appbarWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Do you smoking?',
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
                        smokingList.length,
                        (int index) => Column(
                          children: <Widget>[
                            itemWidget(smokingList[index]),
                            if (index + 1 != smokingList.length)
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
                      onTap: areYouSmoking.value != ''
                          ? () {
                              userModel.smoking = areYouSmoking.value;
                              box.write(
                                StorageKey.currentUser,
                                userModel.toJson(),
                              );
                              Get.to(() => const DrugsScreen());
                            }
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemWidget(String item) {
    return CheckboxListTile(
      value: areYouSmoking.value == item,
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
        areYouSmoking.value = item;
      },
    );
  }
}
