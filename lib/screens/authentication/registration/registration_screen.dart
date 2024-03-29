// ignore_for_file: always_specify_types

import 'package:finder/screens/authentication/login/login_screen.dart';
import 'package:finder/utils/network_dio.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/constant/sizedbox.dart';
import 'package:finder/widget/show_banner_ads.dart';
import 'package:finder/widget/elevated_button.dart';
import 'package:finder/widget/input_text_field.dart';
import 'package:finder/screens/authentication/registration/registration_screen_controller.dart';

class RegistrationScreen extends GetView<RegistrationScreenController> {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationScreenController>(
      init: RegistrationScreenController(),
      builder: (RegistrationScreenController controller) => Scaffold(
        backgroundColor: lightBlack,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    height10,
                    Center(
                      child: Text(
                        'Register Account',
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
                      hintText: 'developer@gmail.com',
                      controller: controller.email,
                      textInputAction: TextInputAction.next,
                    ),
                    height20,
                    Text(
                      'Password',
                      style: mediumText22.copyWith(color: whiteColor),
                    ),
                    height10,
                    PasswordWidget(
                      hintText: 'Abc@123',
                      passType: 'Password',
                      showsuffixIcon: true,
                      textInputAction: TextInputAction.next,
                      controller: controller.password,
                    ),
                    height20,
                    Text(
                      'Confirm Password',
                      style: mediumText22.copyWith(color: whiteColor),
                    ),
                    height10,
                    PasswordWidget(
                      hintText: 'Abcd@123',
                      passType: 'Confirm Password',
                      showsuffixIcon: true,
                      controller: controller.confirmPassword,
                    ),
                    height20,
                    Row(
                      children: [
                        width15,
                        GestureDetector(
                          onTap: () {
                            controller.isTermApply.value =
                                !controller.isTermApply.value;
                          },
                          child: Obx(
                            () => Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: controller.isTermApply.value
                                      ? primary
                                      : darkGrey,
                                ),
                              ),
                              child: controller.isTermApply.value
                                  ? const Icon(
                                      Icons.check,
                                      color: primary,
                                    )
                                  : const SizedBox(),
                            ),
                          ),
                        ),
                        width15,
                        RichText(
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor,
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '''I agree with ''',
                                style: regularText16.copyWith(
                                  color: whiteColor,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: 'Terms & Conditions',
                                style: regularText16.copyWith(
                                  fontSize: 14,
                                  color: primary,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(
                                      () => const LoginScreen(),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    height30,
                    height20,
                    Center(
                      child: elevatedButton(
                        title: 'Send Code',
                        onTap: () {
                          if (controller.password.value ==
                              controller.confirmPassword.value) {
                            controller.sendOtp(context);
                          } else {
                            NetworkDio.showSuccess(
                              title: 'Warning',
                              sucessMessage:
                                  '''Password not match with confirm password''',
                            );
                          }
                        },
                      ),
                    ),
                    height30,
                    Center(
                      child: RichText(
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: '''Already have an account? ''',
                              style: regularText16.copyWith(
                                color: whiteColor,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: 'Sign in',
                              style: regularText16.copyWith(
                                fontSize: 14,
                                color: primary,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.offAll(
                                    () => const LoginScreen(),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: const ShowBannerAds(),
      ),
    );
  }
}
