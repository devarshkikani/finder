import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finder/constant/sizedbox.dart';
import 'package:finder/screens/authentication/sign_in/sign_in_controller.dart';
import 'package:finder/screens/authentication/forgot_password/forgot_password_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/widget/app_bar_widget.dart';
import 'package:finder/widget/input_text_field.dart';

class SignInScreen extends GetView<SignInController> {
  SignInScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailId = TextEditingController();

  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: appbarWidget(title: 'Sign In'),
      body: GetBuilder<SignInController>(
        init: SignInController(),
        builder: (SignInController controller) => Center(
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
                      'Welcome Back!',
                      style: regularText20,
                    ),
                    height30,
                    EmailWidget(
                      labelText: 'Email Id',
                      hintText: 'Enter email here',
                      textInputAction: TextInputAction.next,
                      controller: emailId,
                    ),
                    height20,
                    PasswordWidget(
                      labelText: 'Password',
                      passType: 'Password',
                      hintText: 'Enter password here',
                      controller: password,
                      textInputAction: TextInputAction.next,
                      showsuffixIcon: true,
                      onFieldSubmitted: (String? v) {
                        if (_formKey.currentState!.validate()) {
                          controller.signInOnTap(
                            email: emailId.text,
                            password: password.text,
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
                          controller.signInOnTap(
                            email: emailId.text,
                            password: password.text,
                            context: context,
                          );
                        }
                      },
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(
                          () => ForgotPasswordScreen(),
                        );
                      },
                      child: Text(
                        'Forgot password?',
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
