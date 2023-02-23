// ignore_for_file: prefer_single_quotes

import 'dart:async';
import 'dart:developer';

import 'package:finder/screens/user_info_screen/name_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/utils/network_dio.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/constant/app_endpoints.dart';
import 'package:finder/screens/main_home/main_home_screen.dart';
import 'package:otp_text_field/otp_field.dart';

class VerifyCodeController extends GetxController {
  VerifyCodeController({
    required this.emailAddress,
    required this.isForgot,
  });
  String? emailAddress;
  bool? isForgot;
  RxBool isValid = false.obs;
  RxString otpValue = ''.obs;
  RxString fcmToken = ''.obs;
  OtpFieldController otpController = OtpFieldController();
  GetStorage box = GetStorage();
  late Timer timer;
  RxInt resendOtpTimer = 120.obs;
  Duration clockTimer = const Duration(seconds: 120);
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void onInit() {
    timer = Timer.periodic(
        const Duration(
          seconds: 1,
        ), (Timer timer) {
      if (resendOtpTimer.value > 0) {
        resendOtpTimer.value = resendOtpTimer.value - 1;
        clockTimer = Duration(seconds: resendOtpTimer.value);
      }
    });
    setupSettings();
    super.onInit();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> setupSettings() async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final String? token = await messaging.getToken();

    fcmToken.value = token.toString();
    if (kDebugMode) {
      print('Registration Token=$token');
    }
  }

  Future<void> verifyOtp({
    required BuildContext context,
  }) async {
    final Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.otpVerify,
      data: <String, dynamic>{
        'emailOTP': int.parse(otpValue.value),
        'email': emailAddress,
        'isForgot': isForgot,
        "deviceToken": fcmToken.value
      },
    );
    if (response != null) {
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
    }
  }

  Future<void> resendOtp({
    required BuildContext context,
  }) async {
    final Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.resendOTP,
      data: <String, dynamic>{
        'email': emailAddress,
      },
    );
    if (response != null) {
      NetworkDio.showSuccess(
        title: 'Success',
        sucessMessage: 'OTP has been sent successfully to your email',
      );
      otpController.clear();
      resendOtpTimer.value = 120;
      clockTimer = const Duration(seconds: 120);
    }
  }
}
