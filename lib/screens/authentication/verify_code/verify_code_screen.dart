// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:finder/constant/sizedbox.dart';
import 'package:finder/screens/authentication/verify_code/verify_code_controller.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class VerifyCodeScreen extends GetView<VerifyCodeController> {
  VerifyCodeScreen({super.key});
  static RxBool isValid = false.obs;
  RxString otpValue = ''.obs;
  OtpFieldController otpController = OtpFieldController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            isValid.value = false;
            otpValue.value = '';
            Get.back();
          },
          icon: Icon(
            Platform.isIOS
                ? Icons.arrow_back_ios_new_rounded
                : Icons.arrow_back_rounded,
            color: blackColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    controller.phoneNumber.toString(),
                    style: mediumText16,
                  ),
                  IconButton(
                    onPressed: () {
                      isValid.value = false;
                      otpValue.value = '';
                      Get.back();
                    },
                    iconSize: 18,
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.mode_edit_outline_outlined),
                  ),
                ],
              ),
              Text(
                'Enter your\nVerification code?',
                style: boldText28.copyWith(
                  color: primary,
                  fontFamily: 'source_serif_pro',
                ),
              ),
              height10,
              OTPTextField(
                controller: otpController,
                length: 6,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 45,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 15,
                style: regularText18,
                otpFieldStyle: OtpFieldStyle(
                  borderColor: primary,
                  enabledBorderColor: blackColor,
                  focusBorderColor: primary.withOpacity(0.8),
                ),
                onChanged: (String value) {
                  if (value.length < 6) {
                    isValid.value = false;
                  }
                },
                onCompleted: (String pin) {
                  isValid.value = true;
                  otpValue.value = pin;
                },
              ),
              height20,
              Obx(
                () => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    disabledBackgroundColor: darkGrey,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  onPressed: isValid.value ? () {} : null,
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
              height10,
              TextButton(
                onPressed: () {},
                child: Center(
                  child: Text(
                    'Resend',
                    style: mediumText16.copyWith(
                      color: blackColor,
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
