import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/user_info_screen/ethnicity_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/widget/app_bar_widget.dart';
import 'package:finder/widget/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SelectSexualScreen extends StatelessWidget {
  const SelectSexualScreen({super.key});

  static RxString sexuality = ''.obs;
  static GetStorage box = GetStorage();
  static late UserModel userModel;
  static List<String> sexualityList = <String>[
    'Straight',
    'Gay',
    'Lesbian',
    'Bisexual',
    'Asexual',
    'Demisexual',
    'Other',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "What's your sexual\norientation?",
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
                      sexualityList.length,
                      (int index) => Column(
                        children: <Widget>[
                          itemWidget(sexualityList[index]),
                          if (index + 1 != sexualityList.length)
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
                    onTap: sexuality.value != ''
                        ? () {
                            userModel.sexuality = sexuality.value;
                            box.write(
                              StorageKey.currentUser,
                              userModel.toJson(),
                            );
                            Get.to(() => const EthnicityScreen());
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
      value: sexuality.value == item,
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
        sexuality.value = item;
      },
    );
  }
}
