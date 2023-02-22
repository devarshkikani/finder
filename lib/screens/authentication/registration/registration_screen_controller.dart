// ignore_for_file: prefer_foreach

import 'package:finder/constant/app_endpoints.dart';
import 'package:finder/utils/network_dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:finder/screens/authentication/verify_code/verify_code_bindings.dart';
import 'package:finder/screens/authentication/verify_code/verify_code_screen.dart';

class RegistrationScreenController extends GetxController {
  RxBool isValid = false.obs;
  RxBool isTermApply = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  Future<void> sendOtp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      await nextFunction(context);
    }
  }

  Future<void> nextFunction(BuildContext context) async {
    final Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.signUp,
      data: <String, dynamic>{
        'email': email.text.trim(),
        'password': password.text.trim(),
      },
    );
    if (response != null) {
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
