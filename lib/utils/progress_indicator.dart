import 'package:finder/constant/default_images.dart';
import 'package:flutter/material.dart';
import 'package:finder/utils/internet_error.dart';

class Circle {
  factory Circle() => _instance;
  Circle.internal();
  static final Circle _instance = Circle.internal();

  static bool entry = false;
  static OverlayEntry viewEntry = OverlayEntry(builder: (BuildContext context) {
    return const ProcessIndicator();
  });

  InternetError internetError = InternetError();

  Future<void> show(BuildContext context) async {
    return addOverlayEntry(context);
  }

  void hide(BuildContext context) => removeOverlay();

  bool get isShow => isShowNetworkOrCircle();

  bool isShowNetworkOrCircle() {
    return internetError.isShow || entry == true;
  }

  Future<void> addOverlayEntry(BuildContext context) async {
    if (entry == true) {
      return;
    }
    entry = true;
    return addOverlay(viewEntry, context);
  }

  Future<void> addOverlay(OverlayEntry entry, BuildContext context) async {
    try {
      return Overlay.of(context).insert(entry);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> removeOverlay() async {
    try {
      entry = false;
      viewEntry.remove();
    } catch (e) {
      return Future.error(e);
    }
  }
}

class ProcessIndicator extends StatelessWidget {
  const ProcessIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Image.asset(
            spinnerGIF,
            height: 100,
            width: 100,
          ),
        ),
      ),
    );
  }
}
