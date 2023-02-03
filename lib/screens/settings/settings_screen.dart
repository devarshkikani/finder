import 'package:finder/constant/divider.dart';
import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/authentication/mobile/mobile_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static GetStorage box = GetStorage();
  static late UserModel userModel;

  RxBool profilePause = false.obs;
  RxBool activeStatus = false.obs;
  @override
  void initState() {
    super.initState();
    userModel = UserModel.fromJson(
        box.read(StorageKey.currentUser) as Map<String, dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlack,
      appBar: AppBar(
        backgroundColor: lightBlack,
        elevation: 0,
        centerTitle: false,
        title: const Text('Settings'),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          dividers(0),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: <Widget>[
                    height20,
                    profileView(),
                    height20,
                    phoneAndEmailView(),
                    height20,
                    notificationView(),
                    height20,
                    membershipView(),
                    height20,
                    languageView(),
                    height20,
                    legalView(),
                    height5,
                    accountView(),
                    height20,
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget profileView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Profile',
          style: regularText20.copyWith(
            color: primary,
          ),
        ),
        dividers(10),
        height20,
        Obx(
          () => profileViewDecoration(
            title: 'Pause',
            status: profilePause.value,
            subtitle:
                '''Pausing prevents your profile from being shown to new people. You can still chat with your current matches.''',
            onChanged: (bool newValue) {
              profilePause.value = newValue;
            },
          ),
        ),
        dividers(20),
        Obx(
          () => profileViewDecoration(
            title: 'Show Last Active Status',
            status: activeStatus.value,
            subtitle:
                '''People viewing your profile can see your last active status , and you can see theirs. Your matches won't be shown your last active status.''',
            onChanged: (bool newValue) {
              activeStatus.value = newValue;
            },
          ),
        ),
      ],
    );
  }

  Widget phoneAndEmailView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone & email',
          style: regularText20.copyWith(
            color: primary,
          ),
        ),
        dividers(10),
        height20,
        Text(
          userModel.phoneNumber,
          style: regularText18.copyWith(
            color: whiteColor,
          ),
        ),
        dividers(20),
        Text(
          userModel.email.toString(),
          style: regularText18.copyWith(
            color: whiteColor,
          ),
        ),
        dividers(20),
      ],
    );
  }

  Widget notificationView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Notifications',
          style: regularText20.copyWith(
            color: primary,
          ),
        ),
        dividers(10),
        height20,
        Text(
          'Push Notifications',
          style: regularText18.copyWith(
            color: whiteColor,
          ),
        ),
        dividers(20),
        Text(
          'Email',
          style: regularText18.copyWith(
            color: whiteColor,
          ),
        ),
        dividers(20),
      ],
    );
  }

  Widget membershipView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Membership',
          style: regularText20.copyWith(
            color: primary,
          ),
        ),
        dividers(10),
        height20,
        Text(
          'Upgrade to Membership',
          style: regularText18.copyWith(
            color: whiteColor,
          ),
        ),
        dividers(20),
      ],
    );
  }

  Widget languageView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Language',
          style: regularText20.copyWith(
            color: primary,
          ),
        ),
        dividers(10),
        height20,
        Text(
          'App Language',
          style: regularText18.copyWith(
            color: whiteColor,
          ),
        ),
        height5,
        Text(
          'English',
          style: regularText16.copyWith(
            color: darkGrey,
          ),
        ),
        dividers(20),
      ],
    );
  }

  Widget legalView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Legal',
          style: regularText20.copyWith(
            color: primary,
          ),
        ),
        dividers(10),
        height20,
        Text(
          'Privacy Policy',
          style: regularText18.copyWith(
            color: whiteColor,
          ),
        ),
        dividers(20),
        Text(
          'Terms of Service',
          style: regularText18.copyWith(
            color: whiteColor,
          ),
        ),
        dividers(20),
        Text(
          'About',
          style: regularText18.copyWith(
            color: whiteColor,
          ),
        ),
        dividers(20),
        Text(
          'Privacy Policy',
          style: regularText18.copyWith(
            color: whiteColor,
          ),
        ),
        dividers(20),
      ],
    );
  }

  Widget accountView() {
    return Column(
      children: <Widget>[
        dividers(20),
        InkWell(
          onTap: () {
            GetStorage().erase();
            Get.offAll(() => const MobileScreen());
          },
          child: Text(
            'Log out',
            style: regularText20.copyWith(
              color: primary,
            ),
          ),
        ),
        dividers(20),
        InkWell(
          onTap: () {},
          child: Text(
            'Delete or Pause Account',
            style: regularText20.copyWith(
              color: primary,
            ),
          ),
        ),
        dividers(20),
      ],
    );
  }

  Widget profileViewDecoration({
    required String title,
    required String subtitle,
    required bool status,
    required Function(bool newValue) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: regularText18.copyWith(
            color: whiteColor,
          ),
        ),
        height5,
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    subtitle,
                    style: regularText16.copyWith(
                      color: darkGrey,
                    ),
                  ),
                ],
              ),
            ),
            width5,
            Switch.adaptive(
              value: status,
              onChanged: onChanged,
            ),
          ],
        ),
      ],
    );
  }
}
