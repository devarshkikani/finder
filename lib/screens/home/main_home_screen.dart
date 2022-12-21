import 'package:finder/screens/chat/chat_screen.dart';
import 'package:finder/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finder/constant/default_images.dart';
import 'package:finder/theme/colors.dart';

class MainHomeScreen extends StatelessWidget {
  MainHomeScreen({super.key});

  static RxInt selectedIndex = 0.obs;
  final List<Widget> pages = <Widget>[
    Container(),
    const ChatScreen(),
    const UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: pages[selectedIndex.value],
        bottomNavigationBar: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    selectedIndex.value = 0;
                  },
                  child: Image.asset(
                    homeIcon,
                    color: selectedIndex.value == 0 ? primary : darkGrey,
                    height: 40,
                    width: 40,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectedIndex.value = 1;
                  },
                  child: Image.asset(
                    chatIcon,
                    color: selectedIndex.value == 1 ? primary : darkGrey,
                    height: 30,
                    width: 30,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectedIndex.value = 2;
                  },
                  child: Image.asset(
                    userPeople,
                    color: selectedIndex.value == 2 ? primary : darkGrey,
                    height: 40,
                    width: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
