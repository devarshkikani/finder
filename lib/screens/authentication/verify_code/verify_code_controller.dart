import 'package:finder/screens/user_info_screen/name_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/utils/network_dio.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/constant/app_endpoints.dart';
import 'package:finder/screens/home/main_home_screen.dart';
import 'package:otp_text_field/otp_field.dart';

class VerifyCodeController extends GetxController {
  VerifyCodeController({
    required this.phoneNumber,
  });
  String? phoneNumber;
  RxBool isValid = false.obs;
  RxString otpValue = ''.obs;
  OtpFieldController otpController = OtpFieldController();

  GetStorage box = GetStorage();

  Future<void> verifyOtp({
    required BuildContext context,
  }) async {
    final Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.otpVerify,
      data: <String, dynamic>{
        'phoneOTP': int.parse(otpValue.value),
        'phoneNumber': phoneNumber,
      },
    );
    if (response != null) {
      final UserModel model =
          UserModel.fromJson(response['response'] as Map<String, dynamic>);
      box
        ..write(StorageKey.apiToken, response['token'])
        ..write(StorageKey.currentUser, model.toJson())
        ..write(StorageKey.userId, response['response']['_id'])
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
}
