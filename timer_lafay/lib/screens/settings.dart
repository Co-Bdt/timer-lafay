import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:timer_lafay/models/timer_entity.dart';
import 'package:timer_lafay/utils/ad_manager.dart';
import 'package:timer_lafay/utils/persistence_manager.dart';
import 'package:timer_lafay/utils/vibration_manager.dart';
import 'package:timer_lafay/widgets/settings_behaviour_parameter.dart';
import 'package:timer_lafay/widgets/settings_timer_picker_button.dart';

import '../utils/ring_manager.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  bool isDuckingActive = false;
  bool isVibrationActive = false;
  List<TimerEntity> durations = [];

  // Ad object of banner format
  BannerAd? _bannerAd;
  // AdSize object to custome the banner ad size
  AdSize _adSize = const AdSize(width: 320, height: 100);

  void loadTimers(Map args) {
    if (args['timers'] != null) {
      for (var i = 0; i < args['timers'].length; i++) {
        durations.add(args['timers'][i]);
      }
    }
  }

  /// Loads and shows a banner ad.
  ///
  /// Dimensions of the ad are determined by the AdSize class.
  void loadAd() async {
    BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      request: const AdRequest(),
      size: _adSize,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    ).load();
  }

  void toggleDucking() {
    setState(() {
      isDuckingActive = !isDuckingActive;
      // Save the value to the shared preferences
      PersistenceManager.store('isDuckingActive', isDuckingActive.toString());
      RingManager.isDuckingActive = isDuckingActive;
    });
  }

  void toggleVibration() {
    if (VibrationManager.hasVibration) {
      setState(() {
        isVibrationActive = !isVibrationActive;
        // Save the value to the shared preferences
        PersistenceManager.store(
            'isVibrationActive', isVibrationActive.toString());
        VibrationManager.isVibrationActive = isVibrationActive;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            backgroundColor: Colors.grey[900],
            title: const Text("Information",
                style: TextStyle(color: Colors.white)),
            content: const Text("Vibration is not available on this device",
                style: TextStyle(color: Colors.white70)),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.amber[600]),
                  ))
            ]),
      );
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute settings and pass them
    loadTimers(ModalRoute.of(context)!.settings.arguments as Map);

    _adSize = AdSize(
        width: MediaQuery.of(context).size.width.toInt() - 20, height: 100);
    loadAd();

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[800],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        toolbarHeight: 65,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_bannerAd != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SafeArea(
                    child: SizedBox(
                      width: _bannerAd!.size.width.toDouble(),
                      height: _bannerAd!.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd!),
                    ),
                  ),
                ),
              ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 18),
              child: Text(
                'Timers',
                style: TextStyle(
                    color: Colors.amber[600],
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TimerPickerButton(1, Duration(seconds: durations[0].duration)),
            TimerPickerButton(2, Duration(seconds: durations[1].duration)),
            TimerPickerButton(3, Duration(seconds: durations[2].duration)),
            TimerPickerButton(4, Duration(seconds: durations[3].duration)),
            TimerPickerButton(5, Duration(seconds: durations[4].duration)),
            TimerPickerButton(6, Duration(seconds: durations[5].duration)),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: const Text(
                'The countdown sound level can be adjusted using the device ring volume.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 20),
              child: Text(
                'Behaviour',
                style: TextStyle(
                    color: Colors.amber[600],
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SettingsBehaviourParameter(
                "Audio Ducking",
                "Lower the volume of other audio on countdown",
                "isDuckingActive",
                isDuckingActive,
                toggleDucking),
            SettingsBehaviourParameter("Vibration", "Vibrate on countdown",
                "isVibrationActive", isVibrationActive, toggleVibration),
          ],
        ),
      ),
    );
  }
}
