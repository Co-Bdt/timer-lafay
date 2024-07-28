import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:timer_lafay/screens/home.dart';
import 'package:timer_lafay/utils/ad_manager.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool isAdLoaded = false;

  // Ad object of banner format
  InterstitialAd? _interstitialAd;

  /// Loads and shows a banner ad.
  ///
  /// Dimensions of the ad are determined by the AdSize class.
  void loadAd() async {
    InterstitialAd.load(
        adUnitId: AdManager.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            // An ad must be deleted when it is no longer needed.
            ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad failed to show full screen content.
              onAdFailedToShowFullScreenContent: (ad, err) {
                ad.dispose();
              },
              // Called when the ad dismissed full screen content.
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
              },
            );
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
            setState(() {
              isAdLoaded = true;
            });
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            sleep(const Duration(
                seconds: 2)); // Wait 2 seconds to show loading screen
            setState(() {
              isAdLoaded = true;
            });
          },
        ));
  }

  @override
  void initState() {
    loadAd();
    super.initState();
  }

  @override
  dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isAdLoaded) {
      return Container(
          color: Colors.grey[800],
          child: const Center(child: CircularProgressIndicator()));
    } else {
      _interstitialAd?.show();
      return const Home();
    }
  }
}
