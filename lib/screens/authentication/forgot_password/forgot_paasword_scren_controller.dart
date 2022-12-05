import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finder/constant/app_endpoints.dart';
import 'package:finder/utils/network_dio.dart';

class ForgotPasswordScreenController extends GetxController {
  Future<void> resetPasswordOntap(
      {required String email, required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.forgotPassword,
      context: context,
      data: {
        'email': email,
      },
    );
    if (response != null) {
      NetworkDio.showSuccess(
        title: 'Suceess',
        sucessMessage: response['message'].toString(),
      );
    }
  }
}
