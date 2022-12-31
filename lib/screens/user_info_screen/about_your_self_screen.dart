import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/user_info_screen/location/location_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/widget/app_bar_widget.dart';
import 'package:finder/widget/elevated_button.dart';
import 'package:finder/widget/input_text_field.dart';
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
    if (aboutYouController.text.length >= 3) {
      isValid.value = true;
    } else {
      isValid.value = false;
    }
    return Scaffold(
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
                cursorHeight: 25,
                maxLines: 3,
                controller: aboutYouController,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                style: regularText20,
                hintStyle: regularText20.copyWith(color: greyColor),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                onChanged: (String? value) {
                  if (aboutYouController.text.length >= 3) {
                    isValid.value = true;
                  } else {
                    isValid.value = false;
                  }
                },
                onFieldSubmitted: isValid.value
                    ? (String? value) {
                        userModel.aboutYourSelf = aboutYouController.text;
                        box.write(StorageKey.currentUser, userModel.toJson());
                        Get.to(() => const LocationScreen());
                      }
                    : null,
              ),
              height20,
              Center(
                child: Obx(
                  () => elevatedButton(
                    title: 'Continue',
                    onTap: isValid.value
                        ? () {
                            userModel.aboutYourSelf = aboutYouController.text;
                            box.write(
                                StorageKey.currentUser, userModel.toJson());
                            Get.to(() => const LocationScreen());
                          }
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
