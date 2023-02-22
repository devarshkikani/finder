import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/user_info_screen/location/location_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/utils/network_dio.dart';
import 'package:finder/widget/app_bar_widget.dart';
import 'package:finder/widget/elevated_button.dart';
import 'package:finder/widget/input_text_field.dart';
import 'package:finder/widget/show_banner_ads.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WriteAboutYouScreen extends StatelessWidget {
  WriteAboutYouScreen({super.key});

  final TextEditingController aboutYouController = TextEditingController();
  static RxBool isValid = false.obs;
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Write a bio to introduce yourself',
                style: boldText34.copyWith(
                  color: primary,
                  fontFamily: 'source_serif_pro',
                ),
              ),
              height20,
              TextFormFieldWidget(
                hintText: "Don't be shy here!",
                autofocus: true,
                maxLines: 3,
                controller: aboutYouController,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
              ),
              height20,
              Center(
                child: elevatedButton(
                  title: 'Continue',
                  onTap: () {
                    if (aboutYouController.text.length >= 3) {
                      userModel.aboutYourSelf = aboutYouController.text;
                      box.write(StorageKey.currentUser, userModel.toJson());
                      Get.to(() => const LocationScreen());
                    } else {
                      NetworkDio.showWarning(
                        message: '''Write more then 3 characters''',
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const ShowBannerAds(),
    );
  }
}
