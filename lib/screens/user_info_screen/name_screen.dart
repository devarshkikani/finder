import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/user_info_screen/birth_date_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/widget/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NameScreen extends StatelessWidget {
  NameScreen({super.key});

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  static RxBool isValid = false.obs;
  static GetStorage box = GetStorage();
  static late UserModel userModel;
  @override
  Widget build(BuildContext context) {
    userModel = UserModel.fromJson(
        box.read(StorageKey.currentUser) as Map<String, dynamic>);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "What's your\nname?",
                style: boldText34.copyWith(
                  color: primary,
                  fontFamily: 'source_serif_pro',
                ),
              ),
              height20,
              TextFormFieldWidget(
                hintText: 'First name',
                autofocus: true,
                cursorHeight: 25,
                controller: firstNameController,
                textInputAction: TextInputAction.next,
                style: regularText20,
                hintStyle: regularText20.copyWith(color: greyColor),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                onChanged: (String? value) {
                  if (firstNameController.text.length >= 3 &&
                      lastNameController.text.length >= 3) {
                    isValid.value = true;
                  } else {
                    isValid.value = false;
                  }
                },
              ),
              height10,
              TextFormFieldWidget(
                hintText: 'Last name',
                controller: lastNameController,
                style: regularText20,
                cursorHeight: 25,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                hintStyle: regularText20.copyWith(color: greyColor),
                onChanged: (String? value) {
                  if (firstNameController.text.length >= 3 &&
                      lastNameController.text.length >= 3) {
                    isValid.value = true;
                  } else {
                    isValid.value = false;
                  }
                },
                onFieldSubmitted: isValid.value
                    ? (String? value) {
                        userModel.firstName = firstNameController.text;
                        userModel.lastName = lastNameController.text;
                        box.write(StorageKey.currentUser, userModel.toJson());
                        Get.to(() => const BirthDateScreen());
                      }
                    : null,
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
                    onPressed: isValid.value
                        ? () {
                            userModel.firstName = firstNameController.text;
                            userModel.lastName = lastNameController.text;
                            box.write(
                                StorageKey.currentUser, userModel.toJson());
                            Get.to(() => const BirthDateScreen());
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
