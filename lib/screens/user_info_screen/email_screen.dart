import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/user_info_screen/birth_date_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/widget/elevated_button.dart';
import 'package:finder/widget/input_text_field.dart';
import 'package:finder/widget/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EmailScreen extends StatelessWidget {
  EmailScreen({super.key});
  final TextEditingController emailController = TextEditingController();
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
                "What's your email address?",
                style: boldText34.copyWith(
                  color: primary,
                  fontFamily: 'source_serif_pro',
                ),
              ),
              height20,
              TextFormFieldWidget(
                hintText: 'abcd@gmail.com',
                autofocus: true,
                cursorHeight: 25,
                controller: emailController,
                textInputAction: TextInputAction.next,
                validator: (String? value) => Validators.validateEmail(value),
                style: regularText20,
                hintStyle: regularText20.copyWith(color: greyColor),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                onChanged: (String? value) {
                  if (Validators.validateEmail(value) == null) {
                    isValid.value = true;
                  } else {
                    isValid.value = false;
                  }
                },
              ),
              height10,
              height20,
              Center(
                child: Obx(
                  () => elevatedButton(
                    title: 'Continue',
                    onTap: isValid.value
                        ? () {
                            userModel.email = emailController.text;
                            box.write(
                                StorageKey.currentUser, userModel.toJson());
                            Get.to(() => const BirthDateScreen());
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
