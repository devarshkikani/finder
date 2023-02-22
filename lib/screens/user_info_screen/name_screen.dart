import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/user_info_screen/birth_date_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/widget/elevated_button.dart';
import 'package:finder/widget/input_text_field.dart';
import 'package:finder/widget/show_banner_ads.dart';
import 'package:finder/widget/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NameScreen extends StatelessWidget {
  NameScreen({super.key});
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static GetStorage box = GetStorage();
  static late UserModel userModel;
  @override
  Widget build(BuildContext context) {
    userModel = UserModel.fromJson(
        box.read(StorageKey.currentUser) as Map<String, dynamic>);
    return Scaffold(
      backgroundColor: lightBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
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
                    controller: firstNameController,
                    textInputAction: TextInputAction.next,
                    validator: (String? value) =>
                        Validators.validateText(value, 'First Name'),
                  ),
                  height10,
                  TextFormFieldWidget(
                    hintText: 'Last name',
                    controller: lastNameController,
                    textInputAction: TextInputAction.done,
                    validator: (String? value) =>
                        Validators.validateText(value, 'Last Name'),
                  ),
                  height30,
                  Center(
                    child: elevatedButton(
                      title: 'Continue',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          userModel.firstName = firstNameController.text;
                          userModel.lastName = lastNameController.text;
                          box.write(StorageKey.currentUser, userModel.toJson());
                          Get.to(() => const BirthDateScreen());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const ShowBannerAds(),
    );
  }
}
