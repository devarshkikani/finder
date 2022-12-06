import 'package:get/get.dart';

class VerifyCodeController extends GetxController {
  VerifyCodeController({
    required this.dialCode,
    required this.phoneNumber,
  });
  String? phoneNumber;
  String? dialCode;
}
