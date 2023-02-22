import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/user_info_screen/drinking_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/widget/app_bar_widget.dart';
import 'package:finder/widget/elevated_button.dart';
import 'package:finder/widget/input_text_field.dart';
import 'package:finder/widget/show_banner_ads.dart';
import 'package:finder/widget/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class JobTitleScreen extends StatelessWidget {
  JobTitleScreen({super.key});
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController jobPlaceController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static GetStorage box = GetStorage();
  static late UserModel userModel;
  @override
  Widget build(BuildContext context) {
    userModel = UserModel.fromJson(
        box.read(StorageKey.currentUser) as Map<String, dynamic>);
    return Scaffold(
      backgroundColor: lightBlack,
      appBar: appbarWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "What's your job?",
                  style: boldText34.copyWith(
                    color: primary,
                    fontFamily: 'source_serif_pro',
                  ),
                ),
                height20,
                TextFormFieldWidget(
                  autofocus: true,
                  hintText: 'Job title',
                  controller: jobTitleController,
                  textInputAction: TextInputAction.next,
                  validator: (String? value) =>
                      Validators.validateText(value, 'Job title'),
                ),
                height10,
                TextFormFieldWidget(
                  hintText: 'Work place',
                  textInputAction: TextInputAction.done,
                  controller: jobPlaceController,
                  autofocus: true,
                  validator: (String? value) =>
                      Validators.validateText(value, 'Work place'),
                ),
                height30,
                Center(
                  child: elevatedButton(
                    title: 'Continue',
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        userModel.jobTitle = jobTitleController.text;
                        userModel.work = jobPlaceController.text;
                        box.write(StorageKey.currentUser, userModel.toJson());
                        Get.to(
                          () => DrinkingScreen(
                            isEdit: false.obs,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const ShowBannerAds(),
    );
  }
}
