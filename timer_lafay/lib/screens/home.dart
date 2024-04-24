import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:async';
import 'package:timer_lafay/models/timer_entity.dart';
import 'package:timer_lafay/utils/persistence_manager.dart';
import 'package:timer_lafay/utils/ring_manager.dart';
import 'package:timer_lafay/utils/extensions.dart';
import 'package:timer_lafay/utils/vibration_manager.dart';
import 'package:timer_lafay/widgets/home_app_bar.dart';
import 'package:timer_lafay/widgets/rep_elevated_button.dart';
import 'package:timer_lafay/widgets/timer_elevated_button.dart';
import 'package:vibration/vibration.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  bool isLoaded = false;
  // Object to manage the countdown
  Timer _timer = Timer(Duration.zero, () {});
  // Boolean to know whether the stopwatch is on or not
  bool isStopwatchOn = false;
  // String that contain the timer currently running in 00'00" format
  String timerOn = '';
  // Integer that contain the timer currently running in seconds format
  int timerOnInSeconds = 0;
  // Number of reps
  Map<num, bool> reps = {
    0: true,
    1: false,
    2: false,
    3: false,
    4: false,
    5: false,
    6: false
  };
  // List of timers
  List<TimerEntity> timers = List.filled(6, TimerEntity(0), growable: false);
  // Ad object of banner format
  BannerAd? _bannerAd;
  // Test ads to avoid using production ads and risk account suspension
  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  void loadGlobalUtils() async {
    await PersistenceManager.initializeSharedPreferences();
    RingManager.configureAudioSession();
    RingManager.loadRing();
    VibrationManager.configureVibration();
    loadUsersPreferences();
    _loadAd();

    // Wait 0.5 second to let the circular loader quickly appear
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      isLoaded = true;
    });
  }

  void loadUsersPreferences() {
    Map<int, int> defaultTimers = {
      1: 25,
      2: 60,
      3: 90,
      4: 120,
      5: 180,
      6: 300,
    };
    setState(() {
      for (var i = 0; i < timers.length; i++) {
        var value = PersistenceManager.get('timer${i + 1}');
        timers[i] =
            TimerEntity(value != "" ? int.parse(value) : defaultTimers[i + 1]!);
      }
    });
    VibrationManager.isVibrationEnabled =
        PersistenceManager.get('isVibrationActive').toBoolean();
  }

  int whichRepButtonIsPressed() {
    for (var i = 0; i < reps.length; i++) {
      if (reps[i] == true) {
        return i;
      }
    }
    return 0;
  }

  void pressRepButton(int number) {
    setState(() {
      for (var i = 0; i < reps.length; i++) {
        if (i == number) {
          reps[i] = true;
        } else {
          reps[i] = false;
        }
      }
    });
  }

  Future<void> startTimer() async {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) async {
        if (timerOnInSeconds == 0) {
          await RingManager.session.setActive(false);

          setState(() {
            timer.cancel();
            isStopwatchOn = false;
          });
        } else {
          if (timerOnInSeconds == 1) {
            await RingManager.pool.play(RingManager.gongId);
          }
          if (timerOnInSeconds < 7 && timerOnInSeconds > 1) {
            await RingManager.session.setActive(true);
            await RingManager.pool.play(RingManager.ringId);

            // If the user has enabled vibration
            if (VibrationManager.isVibrationEnabled) {
              if (VibrationManager.hasAmplitudeControl) {
                Vibration.vibrate(duration: 250, amplitude: 128);
              } else {
                Vibration.vibrate(duration: 250);
              }
            }
          }

          setState(() {
            timerOnInSeconds--;
            timerOn = TimerEntity(timerOnInSeconds).getTimer();
          });
        }
      },
    );
  }

  startStopwatch(int timerIndex) {
    setState(() {
      isStopwatchOn = true;
      timerOn = timers[timerIndex].getTimer();
      timerOnInSeconds = timers[timerIndex].duration.toInt();
      if (whichRepButtonIsPressed() != 0) {
        pressRepButton(whichRepButtonIsPressed() - 1);
      }
      startTimer();
    });
  }

  /// Loads and shows a banner ad.
  ///
  /// Dimensions of the ad are determined by the AdSize class.
  void _loadAd() async {
    BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
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
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {},
      ),
    ).load();
  }

  @override
  void initState() {
    loadGlobalUtils();
    super.initState();
  }

  @override
  void dispose() {
    if (_timer.isActive) _timer.cancel();
    RingManager.pool.release();
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      return Container(
          color: Colors.grey[800],
          child: const Center(child: CircularProgressIndicator()));
    } else {
      return Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: HomeAppBar(
            timers: timers,
            onPop: () => loadUsersPreferences(),
          ),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RepElevatedButton(
                            number: '0',
                            press: reps[0],
                            pressRepButton: () {
                              pressRepButton(0);
                            }),
                        RepElevatedButton(
                            number: '1',
                            press: reps[1],
                            pressRepButton: () {
                              pressRepButton(1);
                            }),
                        RepElevatedButton(
                            number: '2',
                            press: reps[2],
                            pressRepButton: () {
                              pressRepButton(2);
                            }),
                        RepElevatedButton(
                            number: '3',
                            press: reps[3],
                            pressRepButton: () {
                              pressRepButton(3);
                            }),
                        RepElevatedButton(
                            number: '4',
                            press: reps[4],
                            pressRepButton: () {
                              pressRepButton(4);
                            }),
                        RepElevatedButton(
                            number: '5',
                            press: reps[5],
                            pressRepButton: () {
                              pressRepButton(5);
                            }),
                        RepElevatedButton(
                            number: '6',
                            press: reps[6],
                            pressRepButton: () {
                              pressRepButton(6);
                            }),
                      ],
                    ),
                  ),
                ),
                if (!isStopwatchOn) ...[
                  Flexible(
                      flex: 14,
                      fit: FlexFit.tight,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TimerElevatedButton(
                              timer: timers[0].getTimer(),
                              startStopWatch: () async {
                                startStopwatch(0);
                              },
                            ),
                            TimerElevatedButton(
                              timer: timers[1].getTimer(),
                              startStopWatch: () {
                                startStopwatch(1);
                              },
                            )
                          ],
                        ),
                      )),
                  Flexible(
                      flex: 14,
                      fit: FlexFit.tight,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TimerElevatedButton(
                              timer: timers[2].getTimer(),
                              startStopWatch: () {
                                startStopwatch(2);
                              },
                            ),
                            TimerElevatedButton(
                              timer: timers[3].getTimer(),
                              startStopWatch: () {
                                startStopwatch(3);
                              },
                            ),
                          ],
                        ),
                      )),
                  Flexible(
                    flex: 14,
                    fit: FlexFit.tight,
                    child: Container(
                        margin: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TimerElevatedButton(
                              timer: timers[4].getTimer(),
                              startStopWatch: () {
                                startStopwatch(4);
                              },
                            ),
                            TimerElevatedButton(
                              timer: timers[5].getTimer(),
                              startStopWatch: () {
                                startStopwatch(5);
                              },
                            )
                          ],
                        )),
                  ),
                ],
                if (isStopwatchOn) ...[
                  Expanded(
                    flex: 21,
                    child: Container(
                        alignment: Alignment.center,
                        child: (Text(
                          timerOn,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 60),
                        ))),
                  ),
                  Expanded(
                    flex: 21,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _timer.cancel();
                              isStopwatchOn = false;
                              if (reps[0] != true) {
                                pressRepButton(whichRepButtonIsPressed() + 1);
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                          ),
                          child: const Text(
                            'STOP',
                            style: TextStyle(fontSize: 40),
                          )),
                    ),
                  ),
                ],
              ]));
    }
  }
}
