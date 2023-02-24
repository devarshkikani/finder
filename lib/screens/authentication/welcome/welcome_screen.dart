import 'dart:io';
import 'dart:ui';

import 'package:finder/screens/authentication/registration/registration_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:finder/theme/colors.dart';
// import 'package:finder/constant/ads_id.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/constant/sizedbox.dart';
// import 'package:finder/constant/show_ads.dart';
import 'package:finder/widget/outline_button.dart';
import 'package:finder/widget/elevated_button.dart';
import 'package:finder/constant/default_images.dart';
import 'package:finder/screens/authentication/login/login_screen.dart';
import 'package:finder/screens/authentication/welcome/welcome_screen_controller.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WelcomeScreenController>(
      init: WelcomeScreenController(),
      builder: (WelcomeScreenController controller) => Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                color: whiteColor,
                image: DecorationImage(
                  image: ExactAssetImage(authBackground),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.5),
              padding: const EdgeInsets.all(20),
              height: Get.height,
              width: Get.width,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      height30,
                      Center(
                        child: Image.asset(
                          appLogoTransparent,
                          height: 150,
                          width: 150,
                        ),
                      ),
                      height30,
                      Text(
                        'Hello!',
                        style: blackText40.copyWith(
                          color: whiteColor,
                          fontFamily: 'source_serif_pro',
                        ),
                      ),
                      Text(
                        '''Welcome to our application. Find your \npartner here enjoy your life.''',
                        textAlign: TextAlign.center,
                        style: boldText16.copyWith(
                          color: whiteColor,
                        ),
                      ),
                      height30,
                      elevatedButton(
                        title: 'Login',
                        backgroundColor: whiteColor,
                        textColor: blackColor,
                        onTap: () {
                          // final ShowAds showAds = ShowAds();
                          // if (showAds
                          //     .placements[
                          //         AdsIds.interstitialVideoAdPlacementId]!
                          //     .value) {
                          //   showAds.showAd(
                          //     AdsIds.interstitialVideoAdPlacementId,
                          //     () {
                          Get.to(
                            () => const LoginScreen(),
                          );
                          //   },
                          // );
                          // }
                        },
                      ),
                      height30,
                      outlinedButton(
                        title: 'Sign Up',
                        textColor: primary,
                        onTap: () {
                          // final ShowAds showAds = ShowAds();
                          // if (showAds
                          //     .placements[
                          //         AdsIds.interstitialVideoAdPlacementId]!
                          //     .value) {
                          //   showAds.showAd(
                          //     AdsIds.interstitialVideoAdPlacementId,
                          //     () {
                          Get.to(
                            () => const RegistrationScreen(),
                          );
                          //   },
                          // );
                          // }
                        },
                      ),
                      height30,
                      orView(),
                      height30,
                      bottomSignUpOption(controller, context),
                      height30,
                      Center(
                        child: RichText(
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor,
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    '''By tapping 'Login' or 'Sign Up', you agree to our ''',
                                style: regularText16.copyWith(
                                  color: whiteColor,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: 'Terms of Use',
                                style: regularText16.copyWith(
                                  fontSize: 14,
                                  color: primary,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                              TextSpan(
                                text:
                                    '''. Learn how we process your data in our ''',
                                style: regularText16.copyWith(
                                  color: whiteColor,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: regularText16.copyWith(
                                  fontSize: 14,
                                  color: primary,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                              TextSpan(
                                text: ''' and ''',
                                style: regularText16.copyWith(
                                  color: whiteColor,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: 'Cookie Policy',
                                style: regularText16.copyWith(
                                  fontSize: 14,
                                  color: primary,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
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
          ],
        ),
      ),
    );
  }

  Widget orView() {
    return Row(
      children: <Widget>[
        width30,
        const Expanded(
          child: Divider(
            color: whiteColor,
          ),
        ),
        Text(
          '''    OR    ''',
          textAlign: TextAlign.center,
          style: boldText16.copyWith(
            color: whiteColor,
          ),
        ),
        const Expanded(
          child: Divider(
            color: whiteColor,
          ),
        ),
        width30,
      ],
    );
  }

  Widget bottomSignUpOption(
    WelcomeScreenController controller,
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        if (Platform.isIOS)
          GestureDetector(
            onTap: () {
              controller.appleLogin(context);
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                color: blackColor,
                shape: BoxShape.circle,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    appleLogo,
                    height: 35,
                    width: 35,
                    color: whiteColor,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
        GestureDetector(
          onTap: () {
            controller.googleLogin(context);
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              color: whiteColor,
              shape: BoxShape.circle,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  googleLogo,
                  height: 35,
                  width: 35,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              color: facebookColor,
              shape: BoxShape.circle,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  facebookLogo,
                  height: 35,
                  width: 35,
                  color: whiteColor,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
