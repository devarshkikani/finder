// ignore_for_file: prefer_foreach

import 'dart:developer';

import 'package:finder/constant/ads_id.dart';
import 'package:finder/constant/app_endpoints.dart';
import 'package:finder/constant/show_ads.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/main_home/main_home_screen.dart';
import 'package:finder/screens/user_info_screen/name_screen.dart';
import 'package:finder/utils/network_dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:finder/screens/authentication/verify_code/verify_code_bindings.dart';
import 'package:finder/screens/authentication/verify_code/verify_code_screen.dart';
import 'package:get_storage/get_storage.dart';

class LoginScreenController extends GetxController {
  RxBool isValid = false.obs;
  GetStorage box = GetStorage();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  Future<void> sendOtp(BuildContext context) async {
    final ShowAds showAds = ShowAds();
    if (showAds.placements[AdsIds.interstitialVideoAdPlacementId]!.value) {
      await nextFunction(context);
    }
  }

  Future<void> nextFunction(BuildContext context) async {
    final Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.signIn,
      data: <String, dynamic>{
        'email': email.text.trim(),
        'password': password.text.trim(),
      },
    );
    if (response != null) {
      if (response['userData']['isEmailVerified'] == true) {
        log(response['userData'].toString());
        final UserModel model =
            UserModel.fromJson(response['userData'] as Map<String, dynamic>);
        box
          ..write(StorageKey.apiToken, response['token'])
          ..write(StorageKey.currentUser, model.toJson())
          ..write(StorageKey.userId, response['userData']['_id'])
          ..write(StorageKey.isLogedIn, true);
        await NetworkDio.setDynamicHeader();
        if (model.isProfileCompleted) {
          Get.offAll(
            () => MainHomeScreen(),
          );
        } else {
          Get.offAll(
            () => NameScreen(),
          );
        }
      } else {
        NetworkDio.showSuccess(
          title: 'Success',
          sucessMessage: 'OTP has been sent successfully to your email',
        );
        Get.to(
          () => const VerifyCodeScreen(),
          binding: VerifyCodeBinding(
            emailAddress: email.text.trim(),
            isForgot: false,
          ),
        );
      }
    }
  }
}
