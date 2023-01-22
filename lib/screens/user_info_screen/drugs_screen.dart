import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/user_info_screen/about_your_self_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/widget/app_bar_widget.dart';
import 'package:finder/widget/elevated_button.dart';
import 'package:finder/widget/show_banner_ads.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DrugsScreen extends StatelessWidget {
  DrugsScreen({
    super.key,
    required this.isEdit,
  });

  RxBool isEdit = false.obs;
  static RxString areYouConsumeDrugs = ''.obs;
  static GetStorage box = GetStorage();
  static late UserModel userModel;
  static List<String> drinkingList = <String>[
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
                  'Do you consume drugs?',
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
                        drinkingList.length,
                        (int index) => Column(
                          children: <Widget>[
                            itemWidget(drinkingList[index]),
                            if (index + 1 != drinkingList.length)
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
                      title: isEdit.value ? 'Save' : 'Continue',
                      onTap: areYouConsumeDrugs.value != ''
                          ? () {
                              userModel.drugs = areYouConsumeDrugs.value;
                              box.write(
                                StorageKey.currentUser,
                                userModel.toJson(),
                              );
                              if (isEdit.value) {
                                Get.back(
                                  result: true,
                                );
                              } else {
                                Get.to(() => WriteAboutYouScreen());
                              }
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
      bottomNavigationBar: const ShowBannerAds(),
    );
  }

  Widget itemWidget(String item) {
    return CheckboxListTile(
      value: areYouConsumeDrugs.value == item,
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
        areYouConsumeDrugs.value = item;
      },
    );
  }
}
