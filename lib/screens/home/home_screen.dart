// ignore_for_file: prefer_final_locals

import 'dart:io';
// import 'dart:js';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
// import 'package:finder/constant/app_endpoints.dart';
import 'package:finder/constant/const_variable.dart';
import 'package:finder/constant/default_images.dart';
import 'package:finder/constant/sizedbox.dart';
// import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/home/home_screen_controller.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/utils/network_dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
// import 'package:get_storage/get_storage.dart';

class HomeScreen extends GetView<HomeScreenController> {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
  // static GetStorage box = GetStorage();
  // static late UserModel currentUser;
  // static RxList<UserModel> usersList = <UserModel>[].obs;

  // PageController pageController = PageController();
  // @override
  // void initState() {
  //   super.initState();
  //   // currentUser = UserModel.fromJson(
  //   //     box.read(StorageKey.currentUser) as Map<String, dynamic>);
  //   getUsers();
  // }

  // Future<void> getUsers() async {
  //   final Map<String, dynamic>? resposnse = await NetworkDio.getDioHttpMethod(
  //       url: ApiEndPoints.apiEndPoint + ApiEndPoints.homeAPI, context: context);
  //   if (resposnse != null) {
  //     List<UserModel> users = <UserModel>[];
  //     // ignore: always_specify_types
  //     for (final element in resposnse['data'] as List) {
  //       print(element['birthDate'].toString().replaceAll('T', ' ').trim());
  //       users.add(UserModel.fromJson(element as Map<String, dynamic>));
  //     }
  //     usersList.value = users;
  //   }
  // }

  void showThreeDotDialog(UserModel userModel, BuildContext context) {
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext ctx) {
        return SafeArea(
          child: Container(
            height: 100,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(ctx);
                      showReasonDialog('Remove', userModel, context);
                    },
                    child: Center(
                      child: Text(
                        'Remove',
                        style: regularText16,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  color: darkGrey,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(ctx);
                      showReasonDialog('Block', userModel, context);
                    },
                    child: Center(
                      child: Text(
                        'Block',
                        style: regularText16.copyWith(color: primary),
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

  void showReasonDialog(
      String title, UserModel userModel, BuildContext context) {
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext ctx) {
        return SafeArea(
          child: Container(
            height: 380,
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(ctx);
                    },
                    child: const Icon(
                      Icons.close,
                    ),
                  ),
                ),
                Text(
                  title,
                  style: mediumText24,
                ),
                Text(
                  'Your reason is private',
                  style: mediumText16.copyWith(
                    color: darkGrey,
                  ),
                ),
                height10,
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: ConstVariable.reasonsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pop(ctx);
                          NetworkDio.showError(
                              title: '$title!!',
                              errorMessage:
                                  '''You have been successfully $title ${userModel.firstName}''');
                          controller.moveNextPage();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: darkGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            ConstVariable.reasonsList[index],
                            style: regularText14,
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => PageView.builder(
            itemCount: controller.usersList.length,
            controller: controller.pageController,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) =>
                pageViewBuilderView(controller.usersList[index], context),
          ),
        ),
      ),
    );
  }

  Widget pageViewBuilderView(UserModel userModel, BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                profileView(userModel),
                height20,
                userDetailsView(userModel),
                height20,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: userModel.photos.length,
                  itemBuilder: (BuildContext context, int index) =>
                      imageView(index, userModel),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      showThreeDotDialog(userModel, context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 25),
                      child: Image.asset(
                        threedotsIcon,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10, left: 20),
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(60),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 0.2,
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  controller.moveNextPage();
                },
                child: Image.asset(
                  crossIcon,
                  color: blackColor,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10, right: 20),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(60),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 0.2,
                  ),
                ],
              ),
              child: Center(
                child: LikeButton(
                  bubblesColor: const BubblesColor(
                    dotPrimaryColor: primary,
                    dotSecondaryColor: primary,
                  ),
                  animationDuration: const Duration(
                    milliseconds: 500,
                  ),
                  onTap: (bool isLiked) async {
                    controller.moveNextPage();
                    return !isLiked;
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget profileView(UserModel userModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        height20,
        Text(
          '''${userModel.lastName}, ${age(userModel.birthDate.toString())}''',
          style: mediumText24,
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

  Widget imageView(int index, UserModel userModel) {
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

  Widget userDetailsView(UserModel userModel) {
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
