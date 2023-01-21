import 'dart:io';
import 'package:finder/constant/sizedbox.dart';
import 'package:finder/screens/authentication/mobile/mobile_screen_controller.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class MobileScreen extends GetView<MobileScreenController> {
  const MobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MobileScreenController>(
        init: MobileScreenController(),
        builder: (MobileScreenController controller) => Scaffold(
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
                      Text(
                        'Get OTP',
                        style: mediumText16.copyWith(color: darkGrey),
                      ),
                      height10,
                      Text(
                        "What's your\nPhone Number?",
                        style: boldText28.copyWith(
                          color: primary,
                          fontFamily: 'source_serif_pro',
                        ),
                      ),
                      height10,
                      InternationalPhoneNumberInput(
                        selectorTextStyle: regularText14.copyWith(
                          color: darkGrey,
                        ),
                        initialValue: PhoneNumber(isoCode: 'US'),
                        textFieldController: controller.phoneController,
                        formatInput: false,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        inputBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primary.withOpacity(0.8),
                          ),
                        ),
                        autoFocus: true,
                        textStyle: regularText16.copyWith(
                          color: darkGrey,
                        ),
                        inputDecoration: InputDecoration(
                          hintText: 'Enter your number here',
                          hintStyle: regularText14.copyWith(color: greyColor),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: primary.withOpacity(0.8),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: primary.withOpacity(0.8),
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: blackColor,
                            ),
                          ),
                        ),
                        onInputChanged: (PhoneNumber number) {
                          controller.phoneNumber = number;
                        },
                        onInputValidated: (bool value) {
                          controller.isValid.value = value;
                        },
                        onSubmit: () {
                          controller.sendOtp(context);
                        },
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          trailingSpace: false,
                          showFlags: true,
                          setSelectorButtonAsPrefixIcon: true,
                          leadingPadding: 10,
                          useEmoji: true,
                        ),
                        onSaved: (PhoneNumber number) {
                          controller.phoneNumber = number;
                        },
                      ),
                      height10,
                      Text(
                        '''Finder will send you a text with a verification code. Messgae and data rates may apply.''',
                        style: regularText14.copyWith(
                          color: greyColor,
                        ),
                      ),
                      height20,
                      Obx(() => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                              disabledBackgroundColor:
                                  darkGrey.withOpacity(0.5),
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 20,
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
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
            ));
  }
}
