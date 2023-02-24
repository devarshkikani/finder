import 'dart:developer';

import 'package:finder/constant/app_endpoints.dart';
import 'package:finder/constant/global_singleton.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/main_home/main_home_screen.dart';
import 'package:finder/screens/user_info_screen/name_screen.dart';
import 'package:finder/utils/network_dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class WelcomeScreenController extends GetxController {
  GetStorage box = GetStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  Future<void> googleLogin(BuildContext context) async {
    _googleSignIn.disconnect();

    final GoogleSignInAccount? data = await _googleSignIn.signIn();
    if (data != null) {
      final GoogleSignInAuthentication? authentication =
          await data.authentication;
      if (authentication != null) {
        final Map<String, dynamic>? response =
            await NetworkDio.postDioHttpMethod(
          url: ApiEndPoints.apiEndPoint + ApiEndPoints.googleLogin,
          context: context,
          data: <String, dynamic>{
            'accessToken': authentication.accessToken,
            'idToken': authentication.idToken,
            'deviceToken': GlobalSingleton().deviceToken,
          },
        );
        if (response != null) {
          handleLoginForAll(response);
        }
      } else {
        NetworkDio.showError(
            title: 'Error',
            errorMessage: 'Something went wrong, try again later.');
      }
    } else {
      NetworkDio.showError(
          title: 'Error',
          errorMessage: 'Something went wrong, try again later.');
    }
  }

  Future<void> appleLogin(BuildContext context) async {
    final AuthorizationCredentialAppleID credential =
        await SignInWithApple.getAppleIDCredential(
      scopes: <AppleIDAuthorizationScopes>[
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: 'de.lunaone.flutter.signinwithappleexample.service',
        redirectUri: Uri.parse(
          'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
        ),
      ),
    );
    final Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.appleLogin,
      context: context,
      data: <String, dynamic>{
        'email': credential.email,
        'appleAuthCode': <String?>[credential.identityToken],
        'deviceToken': GlobalSingleton().deviceToken,
      },
    );
    if (response != null) {
      handleLoginForAll(response);
    }
  }

  Future<void> handleLoginForAll(Map<String, dynamic> response) async {
    log(response['userData'].toString());
    final UserModel model =
        UserModel.fromJson(response['userData'] as Map<String, dynamic>);
    box
      ..write(StorageKey.apiToken, response['token'])
      ..write(StorageKey.currentUser, model.toJson())
      ..write(StorageKey.userId, response['userData']['_id'])
      ..write(StorageKey.isLogedIn, true);
    await NetworkDio.setDynamicHeader();
    if (model.isProfileCompleted) {
      Get.offAll(
        () => MainHomeScreen(),
      );
    } else {
      Get.offAll(
        () => NameScreen(),
      );
    }
  }
}
