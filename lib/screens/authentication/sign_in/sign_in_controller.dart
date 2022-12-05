import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:finder/constant/app_endpoints.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/home/main_home_screen.dart';
import 'package:finder/utils/network_dio.dart';

class SignInController extends GetxController {
  GetStorage box = GetStorage();
  Future<void> signInOnTap({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.signIn,
      data: <String, String>{
        'email': email,
        'password': password,
        'ipaddress': '',
        'device_unique_value': '',
      },
    );
    if (response != null) {
      final UserModel model =
          UserModel.fromJson(response['data'] as Map<String, dynamic>);
      box
        ..write(StorageKey.apiToken, response['token'])
        ..write(StorageKey.currentUser, model.toJson())
        ..write(StorageKey.userId, model.userId)
        ..write(StorageKey.isLogedIn, true);
      Get.offAll(
        () => MainHomeScreen(),
      );
    }
  }
}
