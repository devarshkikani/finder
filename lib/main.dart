// ignore_for_file: depend_on_referenced_packages

import 'package:finder/finder_app.dart';
import 'package:finder/utils/network_dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  NetworkDio.setDynamicHeader();
  runApp(const FinderApp());
}
