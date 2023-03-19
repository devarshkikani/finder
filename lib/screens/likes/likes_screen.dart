import 'dart:ui';

import 'package:finder/constant/default_images.dart';
import 'package:finder/widget/elevated_button.dart';
import 'package:finder/widget/outline_button.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/constant/divider.dart';
import 'package:finder/constant/sizedbox.dart';
import 'package:finder/screens/likes/likes_screen_controller.dart';
import 'package:like_button/like_button.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LikesScreenController>(
      init: LikesScreenController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          backgroundColor: lightBlack,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                height10,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Likes',
                    style: mediumText20.copyWith(
                      color: whiteColor,
                    ),
                  ),
                ),
                dividers(10),
                Expanded(
                  child: 1 == 2
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 250,
                                  width: 250,
                                  padding: const EdgeInsets.only(
                                    left: 30,
                                    right: 30,
                                    top: 20,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: lightGrey,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    heartIcon,
                                    color: lightBlack,
                                  ),
                                ),
                                height30,
                                Text(
                                  'Check back soon!',
                                  style: blackText30.copyWith(),
                                ),
                                height10,
                                Text(
                                  '''Here, you can find the people who've Liked you. They can't be very far 😉. In the meantine, feel free to show your best profile😇.''',
                                  style: lightText16.copyWith(
                                    color: darkGrey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                height30,
                                outlinedButton(
                                  title: 'Improve my profile',
                                  textColor: primary,
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: _.getRoomsFunction,
                          color: whiteColor,
                          triggerMode: RefreshIndicatorTriggerMode.onEdge,
                          backgroundColor: success,
                          child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            physics: const BouncingScrollPhysics(),
                            children: List<Widget>.generate(
                              5,
                              (int index) => Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: greyColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        '''https://newprofilepic2.photo-cdn.net//assets/images/article/profile.jpg''',
                                        fit: BoxFit.cover,
                                        height: Get.width * 0.7,
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 5,
                                          sigmaY: 5,
                                        ),
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: darkBlack.withOpacity(0.5),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              width5,
                                              Expanded(
                                                child: Text(
                                                  'Jennifershizuka' ', 18',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: regularText20,
                                                ),
                                              ),
                                              width5,
                                              Center(
                                                child: LikeButton(
                                                  bubblesColor:
                                                      const BubblesColor(
                                                    dotPrimaryColor: primary,
                                                    dotSecondaryColor: primary,
                                                  ),
                                                  animationDuration:
                                                      const Duration(
                                                    milliseconds: 500,
                                                  ),
                                                  onTap: (bool isLiked) async {
                                                    return !isLiked;
                                                  },
                                                ),
                                              ),
                                              width10,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
