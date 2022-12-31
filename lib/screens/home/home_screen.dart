import 'dart:io';
import 'dart:ui';

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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static GetStorage box = GetStorage();
  static late UserModel userModel;
  @override
  void initState() {
    super.initState();
    userModel = UserModel.fromJson(
        box.read(StorageKey.currentUser) as Map<String, dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                profileView(),
                height20,
                userDetailsView(),
                height20,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: userModel.photos.length,
                  itemBuilder: (BuildContext context, int index) =>
                      imageView(index),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        height20,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '''${userModel.lastName}, ${age(userModel.birthDate.toString())}''',
              style: mediumText24,
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Image.asset(
                  threedotsIcon,
                  height: 24,
                  width: 24,
                ),
              ),
            ),
          ],
        ),
        height10,
        Container(
          height: Get.width,
          width: Get.width,
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
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
      ],
    );
  }

  Widget imageView(int index) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          height: Get.width,
          width: Get.width,
          margin: EdgeInsets.only(bottom: index == 0 ? 30 : 0),
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            child: CachedNetworkImage(
              imageUrl: userModel.photos[index].toString(),
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
        if (index == 0)
          Positioned(
            bottom: 10,
            right: 20,
            left: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.5),
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          userModel.aboutYourSelf,
                          style: regularText18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget userDetailsView() {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      runAlignment: WrapAlignment.start,
      spacing: 8,
      runSpacing: 10,
      children: <Widget>[
        userDetailsDecoration(
          image: ethnicityIcon,
          name: userModel.ethnicity,
        ),
        userDetailsDecoration(
          image: personIcon,
          name: userModel.gender,
        ),
        userDetailsDecoration(
          image: heightIcon,
          name: userModel.height,
        ),
        userDetailsDecoration(
          image: webIcon,
          name: userModel.languageSpoken,
        ),
        userDetailsDecoration(
          image: religionIcon,
          name: userModel.religious,
        ),
        userDetailsDecoration(
          image: sexualityIcon,
          name: userModel.sexuality,
        ),
        userDetailsDecoration(
          image: personIcon,
          name: userModel.relationType,
        ),
        userDetailsDecoration(
          image: locationIcon,
          name: userModel.homeTown,
        ),
        userDetailsDecoration(
          image: workIcon,
          name: userModel.jobTitle,
        ),
        userDetailsDecoration(
          image: jobIcon,
          name: userModel.work,
        ),
        userDetailsDecoration(
          image: cigaretteIcon,
          name: userModel.smoking,
        ),
        userDetailsDecoration(
          image: drinkIcon,
          name: userModel.drinking,
        ),
        userDetailsDecoration(
          image: drugsPillsIcon,
          name: userModel.drugs,
        ),
      ],
    );
  }

  Widget userDetailsDecoration({
    required String image,
    required String name,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: darkGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            image,
            height: 25,
            width: 25,
          ),
          width5,
          Text(
            name,
          ),
        ],
      ),
    );
  }

  String age(String date) {
    final String birthday = date;
    final List<String> birthyear = birthday.split('-').toList();
    final int diffrtence =
        DateTime.now().year.toInt() - int.parse(birthyear[0]);
    return diffrtence.toString();
  }
}
