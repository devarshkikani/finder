// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:finder/constant/sizedbox.dart';
import 'package:finder/screens/authentication/verify_code/verify_code_controller.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/utils/network_dio.dart';
import 'package:finder/widget/elevated_button.dart';
import 'package:finder/widget/outline_button.dart';
import 'package:finder/widget/show_banner_ads.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class VerifyCodeScreen extends GetView<VerifyCodeController> {
  const VerifyCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlack,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            controller.isValid.value = false;
            controller.otpValue.value = '';
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                height10,
                Center(
                  child: Text(
                    'Verification code',
                    style: blackText40.copyWith(
                      color: primary,
                      fontFamily: 'source_serif_pro',
                    ),
                  ),
                ),
                height20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '''We have to sent the verification code to your email. please check your inbox.''',
                    textAlign: TextAlign.center,
                    style: mediumText16.copyWith(color: whiteColor),
                  ),
                ),
                height30,
                OTPTextField(
                  controller: controller.otpController,
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 45,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 15,
                  style: regularText18.copyWith(
                    color: whiteColor,
                  ),
                  otpFieldStyle: OtpFieldStyle(
                    borderColor: primary,
                    enabledBorderColor: darkGrey,
                    focusBorderColor: primary.withOpacity(0.8),
                  ),
                  onChanged: (String value) {
                    if (value.length < 6) {
                      controller.isValid.value = false;
                    }
                  },
                  onCompleted: (String pin) async {
                    controller.isValid.value = true;
                    controller.otpValue.value = pin;
                  },
                ),
                height30,
                Obx(
                  () => Center(
                    child: controller.resendOtpTimer.value > 0
                        ? Text(
                            '''${controller.clockTimer.inMinutes.remainder(60).toString()}:${controller.clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}''',
                            style: mediumText24.copyWith(
                              color: secondary,
                            ),
                          )
                        : outlinedButton(
                            title: 'Resend',
                            borderColor: secondary,
                            textColor: secondary,
                            onTap: () {
                              controller.resendOtp(context: context);
                            },
                          ),
                  ),
                ),
                height20,
                Obx(
                  () => Center(
                    child: elevatedButton(
                      onTap: () {
                        if (controller.isValid.value) {
                          controller.verifyOtp(context: context);
                        } else {
                          NetworkDio.showError(
                            title: 'Warning',
                            errorMessage: 'Enter 6 digit code first',
                          );
                        }
                      },
                      title: 'Verify',
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
}
