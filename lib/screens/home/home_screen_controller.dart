import 'package:finder/constant/app_endpoints.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/utils/network_dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  RxList<UserModel> usersList = <UserModel>[].obs;
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'navigator');
  PageController pageController = PageController();
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getUsers();
  }

  Future<void> getUsers() async {
    final Map<String, dynamic>? resposnse = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.homeAPI,
    );
    if (resposnse != null) {
      List<UserModel> users = <UserModel>[];
      // ignore: always_specify_types
      for (final element in resposnse['data'] as List) {
        print(element['birthDate'].toString().replaceAll('T', ' ').trim());
        users.add(UserModel.fromJson(element as Map<String, dynamic>));
      }
      usersList.value = users;
      isLoading.value = false;
    }
  }

  void moveNextPage() {
    pageController.nextPage(
      duration: const Duration(
        seconds: 1,
      ),
      curve: Curves.easeOutSine,
    );
  }
}
