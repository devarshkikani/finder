import 'package:finder/constant/sizedbox.dart';
import 'package:finder/screens/user_info_screen/location/location_screen_contorller.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/widget/app_bar_widget.dart';
import 'package:finder/widget/elevated_button.dart';
import 'package:finder/widget/input_text_field.dart';
import 'package:finder/widget/show_banner_ads.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlack,
      appBar: appbarWidget(),
      body: GetBuilder<LocationScreenController>(
        init: LocationScreenController(),
        builder: (LocationScreenController controller) {
          controller.getCurrentPosition(isNavigate: true);
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Where do you live?',
                      style: boldText34.copyWith(
                        color: primary,
                        fontFamily: 'source_serif_pro',
                      ),
                    ),
                    height20,
                    TextFormFieldWidget(
                      hintText: 'your city',
                      autofocus: true,
                      cursorHeight: 25,
                      controller: controller.cityController,
                      textInputAction: TextInputAction.done,
                      style: regularText20,
                      hintStyle: regularText20.copyWith(color: greyColor),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 18),
                      onChanged: (String? value) {
                        if (controller.cityController.text.length > 3) {
                          controller.isValid.value = true;
                        } else {
                          controller.isValid.value = false;
                        }
                      },
                    ),
                    height20,
                    Center(
                      child: Obx(
                        () => elevatedButton(
                          title: 'Continue',
                          onTap: controller.isValid.value
                              ? () {
                                  controller.continueOnTap();
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
        },
      ),
      bottomNavigationBar: const ShowBannerAds(),
    );
  }
}
