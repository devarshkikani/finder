// ignore_for_file: depend_on_referenced_packages

import 'package:finder/constant/ads_id.dart';
import 'package:finder/constant/show_ads.dart';
import 'package:finder/finder_app.dart';
import 'package:finder/utils/network_dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

void main() async {
  await GetStorage.init();
  NetworkDio.setDynamicHeader();
  await Firebase.initializeApp();
  UnityAds.init(
    gameId: AdsIds.gameId,
    testMode: true,
    onComplete: () {
      print('Initialization Complete');
    },
    onFailed: (UnityAdsInitializationError error, String message) =>
        print('Initialization Failed: $error $message'),
  );
  ShowAds().loadAds();
  runApp(const FinderApp());
}
