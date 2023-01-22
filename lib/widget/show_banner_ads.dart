import 'package:flutter/material.dart';
import 'package:finder/constant/ads_id.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class ShowBannerAds extends StatelessWidget {
  const ShowBannerAds({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          UnityBannerAd(
            placementId: AdsIds.bannerAdPlacementId,
            onLoad: (String placementId) =>
                print('Banner loaded: $placementId'),
            onClick: (String placementId) =>
                print('Banner clicked: $placementId'),
            onFailed: (String placementId, UnityAdsBannerError error,
                    String message) =>
                print(
              'Banner Ad $placementId failed: $error $message',
            ),
          ),
        ],
      ),
    );
  }
}
