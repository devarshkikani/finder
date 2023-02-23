// ignore_for_file: prefer_foreach

import 'dart:developer';

import 'package:finder/constant/app_endpoints.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/main_home/main_home_screen.dart';
import 'package:finder/screens/user_info_screen/name_screen.dart';
import 'package:finder/utils/network_dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:finder/screens/authentication/verify_code/verify_code_bindings.dart';
import 'package:finder/screens/authentication/verify_code/verify_code_screen.dart';
import 'package:get_storage/get_storage.dart';

class LoginScreenController extends GetxController {
  RxString fcmToken = ''.obs;
  GetStorage box = GetStorage();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void onInit() {
    setupSettings();
    super.onInit();
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

  Future<void> sendOtp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
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
        'deviceToken': fcmToken.value,
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
