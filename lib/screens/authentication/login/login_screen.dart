// ignore_for_file: always_specify_types

import 'dart:io';
import 'package:finder/constant/sizedbox.dart';
import 'package:finder/screens/authentication/login/login_screen_controller.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/utils/validator.dart';
import 'package:finder/widget/input_text_field.dart';
import 'package:finder/widget/show_banner_ads.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginScreenController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginScreenController>(
      init: LoginScreenController(),
      builder: (LoginScreenController controller) => Scaffold(
        backgroundColor: lightBlack,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Platform.isIOS
                  ? Icons.arrow_back_ios_new_rounded
                  : Icons.arrow_back_rounded,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                height10,
                Center(
                  child: Text(
                    'Welcome Back!',
                    style: blackText40.copyWith(
                      color: primary,
                      fontFamily: 'source_serif_pro',
                    ),
                  ),
                ),
                height30,
                Text(
                  'Email address',
                  style: mediumText22.copyWith(color: whiteColor),
                ),
                height10,
                EmailWidget(
                  hintText: 'Enter your email here',
                  controller: controller.email,
                  onChanged: (value) {
                    if (Validators.validateEmail(
                                controller.email.text.trim()) ==
                            null &&
                        controller.password.text.length >= 6) {
                      controller.isValid.value = true;
                    } else {
                      controller.isValid.value = false;
                    }
                  },
                  textInputAction: TextInputAction.next,
                ),
                height20,
                Text(
                  'Password',
                  style: mediumText22.copyWith(color: whiteColor),
                ),
                height10,
                PasswordWidget(
                  hintText: 'Enter your password here',
                  passType: 'Password',
                  showsuffixIcon: true,
                  controller: controller.password,
                  onChaged: (value) {
                    if (Validators.validateEmail(
                                controller.email.text.trim()) ==
                            null &&
                        controller.password.text.length >= 6) {
                      controller.isValid.value = true;
                    } else {
                      controller.isValid.value = false;
                    }
                  },
                ),
                Text(
                  '''Finder will send you a text with a verification code.''',
                  style: regularText14.copyWith(
                    color: greyColor,
                  ),
                ),
                height20,
                Obx(() => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        disabledBackgroundColor: darkGrey.withOpacity(0.5),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      onPressed: controller.isValid.value
                          ? () {
                              controller.sendOtp(context);
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
                    )),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const ShowBannerAds(),
      ),
    );
  }
}
