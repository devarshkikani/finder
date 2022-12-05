import 'dart:io';

import 'package:finder/screens/authentication/welcome/welcome_screen_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/default_images.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WelcomeScreenController>(
      init: WelcomeScreenController(),
      builder: (WelcomeScreenController controller) => Scaffold(
        body: Stack(
          children: <Widget>[
            Image.asset(
              authBackground,
              height: Get.height,
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withOpacity(0.5),
              padding: const EdgeInsets.all(20),
              height: Get.height,
              width: Get.width,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Welcome, buddy!',
                      style: blackText28.copyWith(
                          color: whiteColor, fontFamily: 'source_serif_pro'),
                    ),
                    Text(
                      'Click on continue to find your partner.',
                      style: boldText16.copyWith(
                        color: whiteColor,
                      ),
                    ),
                    height30,
                    if (Platform.isIOS)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blackColor,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 20,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        onPressed: () {
                          controller.handleAppleButtonClick();
                        },
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              appleLogo,
                              height: 30,
                              width: 30,
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'Continue with apple',
                                  style: mediumText16.copyWith(
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                            ),
                            width30,
                          ],
                        ),
                      ),
                    if (Platform.isIOS) height15,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: googleColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      onPressed: () async {},
                      child: Row(
                        children: <Widget>[
                          const CircleAvatar(
                            radius: 15,
                            backgroundImage: AssetImage(
                              googleLogo,
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'Continue with google',
                                style: mediumText16.copyWith(
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          ),
                          width30,
                        ],
                      ),
                    ),
                    height15,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: facebookColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            facebookLogo,
                            height: 30,
                            width: 30,
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'Continue with facebook',
                                style: mediumText16.copyWith(
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          ),
                          width30,
                        ],
                      ),
                    ),
                    height15,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: whiteColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            callIcon,
                            height: 30,
                            width: 30,
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'Continue with number',
                                style: mediumText16.copyWith(
                                  color: blackColor,
                                ),
                              ),
                            ),
                          ),
                          width30,
                        ],
                      ),
                    ),
                    height30,
                    Center(
                      child: Text(
                        'By logging in you agree with our Terms & privacy',
                        style: regularText14.copyWith(
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
