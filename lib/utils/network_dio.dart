// ignore_for_file: implementation_imports, avoid_catches_without_on_clauses

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/src/response.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/utils/internet_error.dart';
import 'package:finder/utils/progress_indicator.dart';

class NetworkDio {
  static late Dio _dio;
  static GetStorage box = GetStorage();
  static Circle processIndicator = Circle();
  static late DioCacheManager dioCacheManager;
  static final Options cacheOptions =
      buildCacheOptions(const Duration(seconds: 1), forceRefresh: true);

  static Future<void> setDynamicHeader() async {
    final BaseOptions options =
        BaseOptions(receiveTimeout: 50000, connectTimeout: 50000);
    dioCacheManager = DioCacheManager(CacheConfig());
    final Map<String, String> token = await _getHeaders();
    options.headers.addAll(token);
    _dio = Dio(options);
    // _dio.interceptors.add(_dioCacheManager.interceptor);

    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult event) async {});
  }

  static Future<Map<String, String>> _getHeaders() async {
    final String? apiToken = box.read(StorageKey.apiToken);
    if (kDebugMode) {
      print('~~~~~~~~~~~~~~~~~~~~ X-API-KEY : $apiToken ~~~~~~~~~~~~~~~~~~~');
      print('AUTH KEY : $apiToken ');
    }
    if (apiToken != null) {
      return <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'authorization': apiToken,
        // 'X-AUTH-KEY': ApiEndPoints.authKey,
      };
    } else {
      return <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
    }
  }

  static Future<bool> check() async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static Future<Map<String, dynamic>?> postDioHttpMethod({
    BuildContext? context,
    required String url,
    required dynamic data,
  }) async {
    final bool internet = await check();
    if (internet) {
      if (context != null) {
        processIndicator.show(context);
      }
      try {
        if (kDebugMode) {
          print('+++URL : $url');
          print('+++Data: $data');
        }
        final dio.Response<dynamic> response = await _dio.post(
          url,
          data: data,
          options: cacheOptions,
        );
        if (kDebugMode) {
          print('+++Response: ' '$response');
        }
        Map<String, dynamic> responseBody = <String, dynamic>{};
        if (context != null) {
          processIndicator.hide(context);
        }

        if (response.statusCode == 200) {
          try {
            responseBody =
                json.decode(response.data.toString()) as Map<String, dynamic>;
          } catch (e) {
            responseBody = response.data as Map<String, dynamic>;
          }
          if (responseBody['status'] == 200) {
            return responseBody['data'] as Map<String, dynamic>;
          } else {
            showError(
              title: 'Error',
              errorMessage: responseBody['message'].toString(),
            );
            return null;
          }
        } else {
          showError(
            title: 'Error',
            errorMessage: response.statusMessage.toString(),
          );
          return null;
        }
      } on DioError catch (e) {
        if (kDebugMode) {
          print('DioError +++ ${e.response?.data['message']}');
        }
        if (context != null) {
          processIndicator.hide(context);
        }
        showError(
            title: 'Error', errorMessage: '${e.response?.data['message']}');
        return null;
      } catch (e) {
        if (kDebugMode) {
          print('Catch +++ $e');
        }
        if (context != null) {
          processIndicator.hide(context);
        }
        showError(title: 'Error', errorMessage: e.toString());
        return null;
      }
    } else {
      if (context != null) {
        InternetError.addOverlayEntry(context);
      }
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getDioHttpMethod({
    BuildContext? context,
    required String url,
  }) async {
    final bool internet = await check();
    if (internet) {
      if (context != null) {
        processIndicator.show(context);
      }
      try {
        if (kDebugMode) {
          print('+++URL : $url');
        }
        final dio.Response<dynamic> response = await _dio.get(
          url,
          options: cacheOptions,
        );
        if (kDebugMode) {
          print('+++Response: $response');
        }
        Map<String, dynamic> responseBody = <String, dynamic>{};
        if (context != null) {
          processIndicator.hide(context);
        }

        if (response.statusCode == 200) {
          try {
            responseBody =
                json.decode(response.data.toString()) as Map<String, dynamic>;
          } catch (e) {
            responseBody = response.data as Map<String, dynamic>;
          }
          if (responseBody['status'] == 200) {
            return responseBody['data'] as Map<String, dynamic>;
          } else {
            showError(
              title: 'Error',
              errorMessage: responseBody['message'].toString(),
            );
            return null;
          }
        } else {
          showError(
            title: 'Error',
            errorMessage: response.statusMessage.toString(),
          );
          return null;
        }
      } on DioError catch (e) {
        if (kDebugMode) {
          print('DioError +++ ${e.response?.data['message']}');
        }
        if (context != null) {
          processIndicator.hide(context);
        }
        showError(
            title: 'Error', errorMessage: '${e.response?.data['message']}');
        return null;
      } catch (e) {
        if (kDebugMode) {
          print('Catch +++ $e');
        }
        if (context != null) {
          processIndicator.hide(context);
        }
        showError(title: 'Error', errorMessage: e.toString());
        return null;
      }
    } else {
      if (context != null) {
        InternetError.addOverlayEntry(context);
      }
      return null;
    }
  }

  static Future<Map<String, dynamic>?> putDioHttpMethod({
    BuildContext? context,
    required String url,
    required dynamic data,
  }) async {
    final bool internet = await check();
    if (internet) {
      if (context != null) {
        processIndicator.show(context);
      }
      try {
        if (kDebugMode) {
          print('+++URL : $url');
          print('+++Data: $data');
        }
        final dio.Response<dynamic> response = await _dio.put(
          url,
          data: data,
          options: cacheOptions,
        );
        if (kDebugMode) {
          print('+++Response: ' '$response');
        }
        Map<String, dynamic> responseBody = <String, dynamic>{};
        if (context != null) {
          processIndicator.hide(context);
        }

        if (response.statusCode == 200) {
          try {
            responseBody =
                json.decode(response.data.toString()) as Map<String, dynamic>;
          } catch (e) {
            responseBody = response.data as Map<String, dynamic>;
          }
          if (responseBody['status'] == 200) {
            return responseBody['data'] as Map<String, dynamic>;
          } else {
            showError(
              title: 'Error',
              errorMessage: responseBody['message'].toString(),
            );
            return null;
          }
        } else {
          showError(
            title: 'Error',
            errorMessage: response.statusMessage.toString(),
          );
          return null;
        }
      } on DioError catch (e) {
        if (kDebugMode) {
          print('DioError +++ ${e.response?.data['message']}');
        }
        if (context != null) {
          processIndicator.hide(context);
        }
        showError(
            title: 'Error', errorMessage: '${e.response?.data['message']}');
        return null;
      } catch (e) {
        if (kDebugMode) {
          print('Catch +++ $e');
        }
        if (context != null) {
          processIndicator.hide(context);
        }
        showError(title: 'Error', errorMessage: e.toString());
        return null;
      }
    } else {
      if (context != null) {
        InternetError.addOverlayEntry(context);
      }
      return null;
    }
  }

  static void showSuccess({
    required String title,
    required String sucessMessage,
  }) {
    Get.snackbar(
      title,
      sucessMessage,
      margin: const EdgeInsets.all(15),
      backgroundColor: Colors.greenAccent.withOpacity(0.5),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static void showError({
    required String title,
    required String errorMessage,
  }) {
    Get.snackbar(
      title,
      errorMessage,
      backgroundColor: Colors.redAccent.withOpacity(0.5),
      margin: const EdgeInsets.all(15),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
