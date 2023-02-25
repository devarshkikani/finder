import 'package:finder/screens/main_home/main_home_screen_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/constant/default_images.dart';

class MainHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainHomeScreenController>(
      init: MainHomeScreenController(),
      builder: (MainHomeScreenController controller) => Scaffold(
        backgroundColor: lightBlack,
        body: controller.pages[controller.selectedIndex.value],
        bottomNavigationBar: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            color: lightBlack,
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
                    controller.selectedIndex.value = 0;
                    controller.update();
                  },
                  child: Image.asset(
                    homeIcon,
                    color: controller.selectedIndex.value == 0
                        ? primary
                        : darkGrey,
                    height: 40,
                    width: 40,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.selectedIndex.value = 1;
                    controller.update();
                  },
                  child: Image.asset(
                    chatIcon,
                    color: controller.selectedIndex.value == 1
                        ? primary
                        : darkGrey,
                    height: 30,
                    width: 30,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.selectedIndex.value = 2;
                    controller.update();
                  },
                  child: Image.asset(
                    userPeople,
                    color: controller.selectedIndex.value == 2
                        ? primary
                        : darkGrey,
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
