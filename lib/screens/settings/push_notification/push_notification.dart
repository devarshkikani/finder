import 'package:finder/constant/divider.dart';
import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PushNotificationScreen extends StatefulWidget {
  const PushNotificationScreen({super.key});

  @override
  State<PushNotificationScreen> createState() => _PushNotificationnState();
}

class _PushNotificationnState extends State<PushNotificationScreen> {
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
        title: const Text('Push Notification'),
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
                    allNotification(),
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

  Widget allNotification() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Obx(
          () => profileViewDecoration(
            title: 'All Notification',
            status: profilePause.value,
            onChanged: (bool newValue) {
              profilePause.value = newValue;
            },
          ),
        ),
        dividers(20),
      ],
    );
  }

  Widget profileViewDecoration({
    required String title,
    required bool status,
    required Function(bool newValue) onChanged,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: regularText18.copyWith(
            color: whiteColor,
          ),
        ),
        Switch.adaptive(
          value: status,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
