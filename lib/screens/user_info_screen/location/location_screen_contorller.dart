// ignore_for_file: always_specify_types

import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/widget/location_permission_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocationScreenController extends GetxController {
  final TextEditingController cityController = TextEditingController();
  RxBool isValid = false.obs;
  GetStorage box = GetStorage();
  late UserModel userModel;

  RxString currentAddress = ''.obs;

  Position? _currentPosition;

  @override
  void onInit() {
    super.onInit();
    userModel = UserModel.fromJson(
        box.read(StorageKey.currentUser) as Map<String, dynamic>);
    getCurrentPosition(isNavigate: true);
  }

  Future<bool> handleLocationPermission({required bool isNavigate}) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.to(() => const LocationPermissionScreen());
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.to(() => const LocationPermissionScreen());
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.to(() => const LocationPermissionScreen());
      return false;
    }
    return true;
  }

  Future<bool> getCurrentPosition({required bool isNavigate}) async {
    final bool hasPermission =
        await handleLocationPermission(isNavigate: isNavigate);

    if (!hasPermission) {
      return false;
    }
    try {
      final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _currentPosition = position;
      return _getAddressFromLatLng(_currentPosition!);
    } on Position catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<bool> _getAddressFromLatLng(Position position) async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
              _currentPosition!.latitude, _currentPosition!.longitude)
          .catchError((e) {
        if (kDebugMode) {
          print(e);
        }
      });
      final Placemark place = placemarks[0];

      currentAddress.value =
          '''${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}''';
      userModel.fullAddress = FullAddress(
          address: place.subLocality.toString(),
          latitude: _currentPosition!.latitude.toString(),
          longitude: _currentPosition!.longitude.toString());
      return true;
    } on Placemark catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  void continueOnTap() {
    userModel.fullAddress.address = cityController.text;
    box.write(StorageKey.currentUser, userModel.toJson());
  }
}
