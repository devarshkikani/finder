import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finder/constant/default_images.dart';
import 'package:finder/theme/colors.dart';

class MainHomeScreen extends StatelessWidget {
  MainHomeScreen({super.key});

  static RxInt selectedIndex = 0.obs;
  final List<Widget> pages = <Widget>[
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: pages[selectedIndex.value],
        bottomNavigationBar: Container(
          height: 80,
          padding: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: greyColor.withOpacity(0.2),
            borderRadius: const BorderRadius.only(
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
                    appLogo,
                    color: selectedIndex.value == 0 ? null : Colors.grey,
                    height: 24,
                    width: 24,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectedIndex.value = 1;
                  },
                  child: Image.asset(
                    appLogo,
                    color: selectedIndex.value == 1 ? null : Colors.grey,
                    height: 24,
                    width: 24,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectedIndex.value = 2;
                  },
                  child: Image.asset(
                    appLogo,
                    color: selectedIndex.value == 2 ? null : Colors.grey,
                    height: 24,
                    width: 24,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectedIndex.value = 3;
                  },
                  child: Image.asset(
                    appLogo,
                    color: selectedIndex.value == 3 ? null : Colors.grey,
                    height: 24,
                    width: 24,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectedIndex.value = 4;
                  },
                  child: Icon(
                    Icons.more_horiz_rounded,
                    color: selectedIndex.value == 4 ? primary : Colors.grey,
                    size: 30,
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
