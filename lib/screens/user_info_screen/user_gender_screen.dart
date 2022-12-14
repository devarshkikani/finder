import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/user_info_screen/sexual_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/widget/app_bar_widget.dart';
import 'package:finder/widget/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserGenderScreen extends StatelessWidget {
  const UserGenderScreen({super.key});

  static RxString gender = ''.obs;
  static GetStorage box = GetStorage();
  static late UserModel userModel;

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
                "What's your gender?",
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
                        color: lightBlue,
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
                        color: lightBlue,
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
              height30,
              Center(
                child: Obx(
                  () => elevatedButton(
                    title: 'Continue',
                    onTap: gender.value != ''
                        ? () {
                            userModel.gender = gender.value;
                            box.write(
                              StorageKey.currentUser,
                              userModel.toJson(),
                            );
                            Get.to(() => const SelectSexualScreen());
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
}
