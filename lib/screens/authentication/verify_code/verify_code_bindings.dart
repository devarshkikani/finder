import 'package:finder/screens/authentication/verify_code/verify_code_controller.dart';
import 'package:get/get.dart';

class VerifyCodeBinding implements Bindings {
  VerifyCodeBinding({
    required this.dialCode,
    required this.phoneNumber,
  });
  String? phoneNumber;
  String? dialCode;
  @override
  void dependencies() {
    Get.lazyPut<VerifyCodeController>(() => VerifyCodeController(
          dialCode: dialCode,
          phoneNumber: phoneNumber,
        ));
  }
}
