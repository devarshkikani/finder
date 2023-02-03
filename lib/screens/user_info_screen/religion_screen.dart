// ignore_for_file: must_be_immutable

import 'package:finder/constant/ads_id.dart';
import 'package:finder/constant/show_ads.dart';
import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/user_info_screen/status_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/widget/app_bar_widget.dart';
import 'package:finder/widget/show_banner_ads.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ReligionScreen extends StatelessWidget {
  ReligionScreen({
    super.key,
    required this.isEdit,
  });

  RxBool isEdit = false.obs;

  static GetStorage box = GetStorage();
  static late UserModel userModel;
  static List<String> religiousList = <String>[
    'Agnostic',
    'Atheist',
    'Buddhist',
    'Catholic',
    'Christian',
    'Hindu',
    'Jain',
    'Jewish',
    'Mormon',
    'Muslim',
    'Sikh',
    'Spiritual',
    'Zoroastrian',
    'Other',
  ];
  @override
  Widget build(BuildContext context) {
    userModel = UserModel.fromJson(
        box.read(StorageKey.currentUser) as Map<String, dynamic>);
    return Scaffold(
      appBar: appbarWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "What's your religious beliefs?",
                style: boldText34.copyWith(
                  color: primary,
                  fontFamily: 'source_serif_pro',
                ),
              ),
              height20,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List<Widget>.generate(
                      religiousList.length,
                      (int index) => InkWell(
                        onTap: () {
                          final ShowAds showAds = ShowAds();
                          if (showAds
                              .placements[
                                  AdsIds.interstitialVideoAdPlacementId]!
                              .value) {
                            showAds.showAd(
                              AdsIds.interstitialVideoAdPlacementId,
                              () {
                                userModel.religious = religiousList[index];
                                box.write(
                                  StorageKey.currentUser,
                                  userModel.toJson(),
                                );
                                if (isEdit.value) {
                                  Get.back(result: true);
                                } else {
                                  Get.to(() => StatusScreen(
                                        isEdit: false.obs,
                                      ));
                                }
                              },
                            );
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Text(
                                religiousList[index],
                                style: mediumText20.copyWith(
                                  color: blackColor,
                                ),
                              ),
                            ),
                            Container(
                              height: 0.5,
                              color: lightBlue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              height20,
            ],
          ),
        ),
      ),
      bottomNavigationBar: const ShowBannerAds(),
    );
  }
}
