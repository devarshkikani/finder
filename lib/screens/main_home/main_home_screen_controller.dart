import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/chat/chat_screen.dart';
import 'package:finder/screens/home/home_screen.dart';
import 'package:finder/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainHomeScreenController extends FullLifeCycleController {
  RxInt selectedIndex = 0.obs;
  GetStorage box = GetStorage();
  late UserModel currentUser;
  final List<Widget> pages = <Widget>[
    HomeScreen(),
    ChatScreen(),
    const UserProfileScreen(),
  ];

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    currentUser = UserModel.fromJson(
        box.read(StorageKey.currentUser) as Map<String, dynamic>);
    super.onInit();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        onPaused();
        break;
      case AppLifecycleState.detached:
        onDetached();
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  void onResumed() {
    updateUserStatus(isActive: true);
  }

  void onPaused() {
    updateUserStatus(isActive: false);
  }

  void onDetached() {
    updateUserStatus(isActive: false);
  }

  Future<void> updateUserStatus({required bool isActive}) async {
    //final Map<String, dynamic>? resposnse = await NetworkDio.postDioHttpMethod(
    //   url: ApiEndPoints.apiEndPoint + ApiEndPoints.updateUserStatus,
    //   context: navigatorKey.currentContext,
    //   data: <String, dynamic>{
    //     'status': isActive,
    //   },
    // );
    // if (resposnse != null) {
    //   currentUser.isActive = isActive;
    //   box.write(StorageKey.currentUser, currentUser.toJson());
    //  }
  }
}
