import 'package:finder/screens/authentication/verify_code/verify_code_controller.dart';
import 'package:get/get.dart';

class VerifyCodeBinding implements Bindings {
  VerifyCodeBinding({
    required this.emailAddress,
    required this.isForgot,
  });
  String? emailAddress;
  bool? isForgot;
  @override
  void dependencies() {
    Get.lazyPut<VerifyCodeController>(
      () => VerifyCodeController(
        emailAddress: emailAddress,
        isForgot: isForgot,
      ),
    );
  }
}
