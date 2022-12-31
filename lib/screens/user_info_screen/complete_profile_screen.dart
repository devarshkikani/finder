import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:finder/constant/app_endpoints.dart';
import 'package:finder/constant/default_images.dart';
import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/main_home/main_home_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/utils/network_dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  static GetStorage box = GetStorage();
  static late UserModel userModel;
  @override
  void initState() {
    userModel = UserModel.fromJson(
        box.read(StorageKey.currentUser) as Map<String, dynamic>);
    userModel.isProfileCompleted = true;
    updateUser(context: context);
    super.initState();
  }

  Future<void> updateUser({
    required BuildContext context,
  }) async {
    final Map<String, dynamic>? response = await NetworkDio.putDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.registerUserDetails,
      data: userModel.toJson(),
    );
    if (response != null) {
      box.write(StorageKey.isLogedIn, true);
      Future<void>.delayed(const Duration(seconds: 5), () {
        Get.offAll(
          () => MainHomeScreen(),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff023241),
      body: SafeArea(
        child: AnimationLimiter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimationConfiguration.staggeredList(
                position: 1,
                duration: const Duration(milliseconds: 400),
                child: SlideAnimation(
                  verticalOffset: -44,
                  child: FadeInAnimation(
                    child: Image.asset(
                      checkGIF,
                    ),
                  ),
                ),
              ),
              AnimationConfiguration.staggeredList(
                position: 2,
                duration: const Duration(seconds: 5),
                child: SlideAnimation(
                  verticalOffset: -44,
                  child: FadeInAnimation(
                    child: Text(
                      "It's Done!",
                      style: boldText34.copyWith(
                        fontFamily: 'source_serif_pro',
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
              height5,
              AnimationConfiguration.staggeredList(
                position: 3,
                duration: const Duration(seconds: 10),
                child: FadeInAnimation(
                  child: Container(
                    height: 30,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AnimatedTextKit(
                        totalRepeatCount: 1,
                        animatedTexts: <TypewriterAnimatedText>[
                          TypewriterAnimatedText(
                            'You have completed your profile',
                            cursor: '',
                            speed: const Duration(milliseconds: 100),
                            textStyle: mediumText20.copyWith(
                              color: whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              height30,
              height30,
              height30,
            ],
          ),
        ),
      ),
    );
  }
}
