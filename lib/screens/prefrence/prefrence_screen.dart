import 'package:finder/constant/default_images.dart';
import 'package:finder/constant/sizedbox.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:flutter/material.dart';

class PrefrenceScreen extends StatefulWidget {
  const PrefrenceScreen({super.key});

  @override
  State<PrefrenceScreen> createState() => _PrefrenceScreenState();
}

class _PrefrenceScreenState extends State<PrefrenceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              comingSoon,
              width: 300,
            ),
            height20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                '''We are new here. so our developer is working hard for new functionality so till enjoy our current functionality.''',
                textAlign: TextAlign.center,
                style: regularText14.copyWith(
                  color: whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
