// ignore_for_file: prefer_foreach

import 'package:finder/constant/ads_id.dart';
import 'package:finder/constant/app_endpoints.dart';
import 'package:finder/constant/show_ads.dart';
import 'package:finder/utils/network_dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:finder/screens/authentication/verify_code/verify_code_bindings.dart';
import 'package:finder/screens/authentication/verify_code/verify_code_screen.dart';

class MobileScreenController extends GetxController {
  RxBool isValid = false.obs;
  final TextEditingController phoneController = TextEditingController();
  late PhoneNumber phoneNumber;

  Future<void> sendOtp(BuildContext context) async {
    final ShowAds showAds = ShowAds();
    if (showAds.placements[AdsIds.interstitialVideoAdPlacementId]!.value) {
      showAds.showAd(
        AdsIds.interstitialVideoAdPlacementId,
        () async {
          await nextFunction(context);
        },
      );
    }
  }

  Future<void> nextFunction(BuildContext context) async {
    final Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.sendOtp,
      data: <String, dynamic>{
        'countryCode': phoneNumber.dialCode?.replaceAll('+', ''),
        'phoneNumber':
            phoneNumber.phoneNumber?.replaceAll(phoneNumber.dialCode!, ''),
      },
    );
    if (response != null) {
      NetworkDio.showSuccess(
        title: 'Success',
        sucessMessage: 'OTP has been sent successfully to your mobile number',
      );
      Get.to(
        () => const VerifyCodeScreen(),
        binding: VerifyCodeBinding(
          phoneNumber:
              phoneNumber.phoneNumber?.replaceAll(phoneNumber.dialCode!, ''),
        ),
      );
    }
  }
}
