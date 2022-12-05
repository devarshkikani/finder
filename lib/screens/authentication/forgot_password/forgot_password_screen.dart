import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finder/constant/sizedbox.dart';
import 'package:finder/screens/authentication/forgot_password/forgot_paasword_scren_controller.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/widget/app_bar_widget.dart';
import 'package:finder/widget/input_text_field.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordScreenController> {
  ForgotPasswordScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: appbarWidget(title: 'Forgot Password'),
      body: GetBuilder<ForgotPasswordScreenController>(
        init: ForgotPasswordScreenController(),
        builder: (ForgotPasswordScreenController controller) => Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Forgot Your Password?',
                      style: regularText20,
                    ),
                    height10,
                    Text(
                      '''Wee get it. stuff happens. Just enter your email address below and we'll send you a Verification code to reset password!''',
                      style: lightText14,
                    ),
                    height25,
                    EmailWidget(
                      labelText: 'Email Address',
                      hintText: 'Enter email here',
                      textInputAction: TextInputAction.next,
                      controller: emailId,
                      onFieldSubmitted: (_) {
                        if (_formKey.currentState!.validate()) {
                          controller.resetPasswordOntap(
                            email: emailId.text,
                            context: context,
                          );
                        }
                      },
                    ),
                    height20,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        maximumSize: Size(Get.width, 50),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.resetPasswordOntap(
                            email: emailId.text,
                            context: context,
                          );
                        }
                      },
                      child: const Text(
                        'RESET PASSWORD',
                        style: TextStyle(
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Existing User Login Here',
                        style: lightText14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
