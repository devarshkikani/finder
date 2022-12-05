import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:finder/constant/app_endpoints.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/home/main_home_screen.dart';
import 'package:finder/utils/network_dio.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class WelcomeScreenController extends GetxController {
  GetStorage box = GetStorage();

  Future<void> signUpOnTap({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirm,
    required String branchId,
    required String gid,
    String? legalBusinessName,
    String? businessContactPerson,
    String? positionInCompany,
    required BuildContext context,
  }) async {
    final Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.signUp,
      data: gid == '0'
          ? <String, dynamic>{
              'firstname': firstName,
              'email': email,
              'password': password,
              'lastname': lastName,
              'password_confirm': passwordConfirm,
              'branch_id': branchId,
              'g_id': gid,
            }
          : <String, dynamic>{
              'firstname': firstName,
              'email': email,
              'password': password,
              'lastname': lastName,
              'password_confirm': passwordConfirm,
              'branch_id': branchId,
              'g_id': gid,
              'legal_business_name': legalBusinessName,
              'business_contact_person': businessContactPerson,
              'position_in_company': positionInCompany,
            },
    );
    if (response != null) {
      NetworkDio.showSuccess(
        title: 'Success',
        sucessMessage: response['message'].toString(),
      );
      final UserModel model =
          UserModel.fromJson(response['data'] as Map<String, dynamic>);
      box
        ..write(StorageKey.apiToken, response['token'])
        ..write(StorageKey.currentUser, model.toJson())
        ..write(StorageKey.userId, model.userId)
        ..write(StorageKey.isLogedIn, true);
      Get.offAll(
        () => MainHomeScreen(),
      );
    }
  }

  Future<void> handleAppleButtonClick() async {
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
    print(credential.email);
  }
}
