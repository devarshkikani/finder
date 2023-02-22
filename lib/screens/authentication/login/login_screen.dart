// ignore_for_file: always_specify_types

import 'dart:io';
import 'package:finder/constant/sizedbox.dart';
import 'package:finder/screens/authentication/login/login_screen_controller.dart';
import 'package:finder/screens/authentication/registration/registration_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/widget/elevated_button.dart';
import 'package:finder/widget/input_text_field.dart';
import 'package:finder/widget/show_banner_ads.dart';
import 'package:flutter/gestures.dart';
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
                      hintText: 'Abcd@123',
                      passType: 'Password',
                      showsuffixIcon: true,
                      controller: controller.password,
                    ),
                    height15,
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password?',
                        style: mediumText14.copyWith(color: whiteColor),
                      ),
                    ),
                    height30,
                    height10,
                    Center(
                      child: elevatedButton(
                        title: 'Send Code',
                        onTap: () {
                          controller.sendOtp(context);
                        },
                      ),
                    ),
                    height30,
                    height10,
                    Center(
                      child: RichText(
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: '''You don't have an account? ''',
                              style: regularText16.copyWith(
                                color: whiteColor,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: 'Sign up',
                              style: regularText16.copyWith(
                                fontSize: 14,
                                color: primary,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.offAll(
                                    () => const RegistrationScreen(),
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
