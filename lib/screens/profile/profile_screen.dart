import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:finder/constant/default_images.dart';
import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  static GetStorage box = GetStorage();
  static late UserModel userModel;
  @override
  void initState() {
    super.initState();
    userModel = UserModel.fromJson(
        box.read(StorageKey.currentUser) as Map<String, dynamic>);
  }

  String age(String date) {
    final String birthday = date;
    final List<String> birthyear = birthday.split('-').toList();
    final int diffrtence =
        DateTime.now().year.toInt() - int.parse(birthyear[0]);
    return diffrtence.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[whiteColor, primary.withOpacity(0.4)],
              begin: const FractionalOffset(1, 0.9),
              end: const FractionalOffset(3, -3),
              stops: const <double>[0, 2],
              tileMode: TileMode.clamp,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                height30,
                profileView(),
                height20,
                detailsSection(),
                height30,
                Container(
                  height: 125,
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: darkGrey.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Image.asset(
                            back,
                            height: 100,
                            color: darkGrey.withOpacity(0.1),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            height10,
                            Text(
                              'COMING SOON',
                              style: boldText24.copyWith(
                                color: primary,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '''We are new here. so our developer is working hard for new functionality so till enjoy our current functionality.''',
                              textAlign: TextAlign.center,
                              style: regularText14.copyWith(
                                color: blackColor,
                              ),
                            ),
                            height15,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                height20,
                bottomView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileView() {
    return Column(
      children: <Widget>[
        width20,
        Container(
          height: 130,
          width: 130,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: blackColor,
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(75),
            ),
            child: CachedNetworkImage(
              imageUrl: userModel.photos[0].toString(),
              placeholder: (BuildContext context, String url) => Padding(
                padding: const EdgeInsets.all(70),
                child: Platform.isAndroid
                    ? const CircularProgressIndicator()
                    : const CupertinoActivityIndicator(),
              ),
              errorWidget: (BuildContext context, String url, dynamic error) =>
                  const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
        height20,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '''${userModel.lastName}, ${age(userModel.birthDate.toString())}''',
              style: mediumText24,
            ),
          ],
        ),
      ],
    );
  }

  Widget detailsSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        detailsSectionDecoration(
          title: 'Settings',
          image: settings,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: detailsSectionDecoration(
            title: 'Edit profile',
            image: editIcon,
          ),
        ),
        detailsSectionDecoration(
          title: 'Prefrence',
          image: prefrenceIcon,
        ),
      ],
    );
  }

  Widget bottomView() {
    return Column(
      children: <Widget>[
        Image.asset(
          appLogo,
          height: 100,
        ),
        Text(
          'Version\n   1.0.1',
          style: mediumText14.copyWith(
            color: darkGrey,
          ),
        ),
      ],
    );
  }

  Widget detailsSectionDecoration({
    required String title,
    required String image,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: whiteColor,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  image,
                  height: 40,
                  width: 40,
                ),
              ),
              height10,
              Text(
                title,
                style: mediumText16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
