import 'dart:io';
import 'package:flutter/material.dart';
import 'package:finder/constant/default_images.dart';
import 'package:finder/finder_app.dart';
import 'package:finder/widget/no_internet.dart';

class InternetError {
  factory InternetError() => _instance;
  InternetError.internal();
  static final InternetError _instance = InternetError.internal();

  static OverlayEntry? entry;

  static void show(BuildContext context) => addOverlayEntry(context);
  void hide() => removeOverlay();

  bool get isShow => entry != null;

  static void addOverlayEntry(BuildContext context) {
    if (entry != null) {
      return;
    }
    entry = OverlayEntry(
      builder: (BuildContext buildContext) {
        return LayoutBuilder(
          builder: (_, BoxConstraints constraints) {
            return Material(
              color: Colors.white,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        offline,
                        height: 300,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'No Internet Connection',
                        style: TextStyle(
                          fontSize: 24,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '''You are not connected with internet. make sure your Wi-fi is on, Airplane Mode off and try again.''',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 40,
                        width: 150,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.redAccent.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (await hasNetwork()) {
                              removeOverlay();
                            }
                          },
                          child: const Text(
                            'Try again',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    addoverlay(entry!, context);
  }

  static Future<void> addoverlay(
      OverlayEntry entry, BuildContext context) async {
    navigatorKey.currentState?.push(
      MaterialPageRoute<void>(
        builder: (_) => NoInternet(tryAgain: () {
          removeOverlay();
          Navigator.pop(_);
        }),
      ),
    );
  }

  static Future<bool> hasNetwork() async {
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static void removeOverlay() {
    entry = null;
    entry?.remove();
  }
}
