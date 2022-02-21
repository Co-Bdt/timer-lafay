import 'package:flutter/material.dart';
import 'dart:async';
import 'package:stopwatch_lafay/services/timer_entity.dart';
import 'package:stopwatch_lafay/services/rep_elevated_button.dart';
import 'package:stopwatch_lafay/services/timer_elevated_button.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';
import 'package:audio_session/audio_session.dart';

class Home extends StatefulWidget {
  // final bool hasVibration;

  // Home(this.hasVibration);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // object to manage the countdown
  Timer _timer;
  // boolean to know whether the stopwatch is on or not
  bool isStopwatchOn = false;
  // string that contain the timer currently running in 00'00" format
  String timerOn = '';
  // integer that contain the timer currently running in seconds format
  int timerOnInSeconds = 0;
  // object to play sounds from assets
  static AudioCache player = AudioCache();
  // object to handle device's vibration
  // static Vibration vibration = Vibration();
  // booleans to check if the device has vibration capabilities
  bool hasVibration;
  bool hasAmplitudeControl;
  bool hasCustomVibrationSupport;

  AudioSession session;

  Map<num, bool> reps = {
    0: true,
    1: false,
    2: false,
    3: false,
    4: false,
    5: false,
    6: false
  };
  // "device persistent storage using plugins like shared preferences"
  List<TimerEntity> timers = [
    TimerEntity(25),
    TimerEntity(60),
    TimerEntity(90),
    TimerEntity(120),
    TimerEntity(180),
    TimerEntity(240),
  ];

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

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) async {
        if (timerOnInSeconds == 0) {
          print('session set false');
          await session.setActive(false);
          setState(() {
            timer.cancel();
            this.isStopwatchOn = false;
          });
        } else if (timerOnInSeconds <= 5) {
          print('session set true');
          await session.setActive(true);
          setState(() {
            timerOnInSeconds--;
            timerOn = TimerEntity(timerOnInSeconds).getTimer();
            player.play('audio/mixkit-plastic-bubble-click-1124.mp3');
            // if vibration checkbox is ticked
            // if (hasVibration) {
            //   Vibration.vibrate(duration: 250, amplitude: 128);
            // }
          });
        } else {
          setState(() {
            timerOnInSeconds--;
            timerOn = TimerEntity(timerOnInSeconds).getTimer();
          });
        }
      },
    );
  }

  startStopwatch(int timer) {
    setState(() {
      this.isStopwatchOn = true;
      this.timerOn = this.timers[timer].getTimer();
      timerOnInSeconds = this.timers[timer].duration;
      if (whichRepButtonIsPressed() != 0) {
        pressRepButton(whichRepButtonIsPressed() - 1);
      }
      startTimer();
    });
  }

  onSelected(BuildContext context, int value) async {
    switch (value) {
      case 1:
        await Navigator.pushNamed(context, '/settings',
            arguments: {'arg1': hasVibration});
        setState(() {});
        break;
      case 2:
        launchURL("https://olivier-lafay.com/categorie-produit/nos-livres/");
        break;
      default:
        print('default');
    }
  }

  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void checkVibrationCapabilities() async {
    hasVibration = await Vibration.hasVibrator();
    hasAmplitudeControl = await Vibration.hasAmplitudeControl();
    hasCustomVibrationSupport = await Vibration.hasCustomVibrationsSupport();
  }

  void configureAudioSession() async {
    session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playback,
      avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.duckOthers,
      avAudioSessionMode: AVAudioSessionMode.defaultMode,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.music,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.media,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gainTransientMayDuck,
      androidWillPauseWhenDucked: true,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    player.clear(
        Uri.dataFromString('audio/mixkit-plastic-bubble-click-1124.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    // double widthBy6 = MediaQuery.of(context).size.width / 6;
    // print('screen width=${MediaQuery.of(context).size.width}');
    // print('screen width/6=$widthBy6');

    // pre-load audio file to avoid getting a delay
    player.load('audio/mixkit-plastic-bubble-click-1124.mp3');

    checkVibrationCapabilities();
    configureAudioSession();

    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text(
            'Chrono Lafay',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey[900],
          actions: <Widget>[
            PopupMenuButton<int>(
              color: Colors.grey[900],
              onSelected: (value) => onSelected(context, value),
              itemBuilder: (context) => [
                PopupMenuItem(
                  textStyle: TextStyle(color: Colors.white, fontSize: 16),
                  value: 1,
                  child: Text('Réglages'),
                ),
                PopupMenuItem(
                  textStyle: TextStyle(color: Colors.white, fontSize: 16),
                  value: 2,
                  child: Text('Les livres d\'Olivier Lafay'),
                )
              ],
            )
          ],
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image.asset('assets/image2.jpg'),
              // Expanded(child: Image.asset('assets/image2.jpg'), flex: 7),
              // Expanded(
              //   flex: 1,
              //   child: Container(
              //     alignment: Alignment.center,
              //     color: Colors.red,
              //     child: Text(
              //       'red',
              //       textAlign: TextAlign.center,
              //     ),
              //   ),
              // ),
              // Expanded(
              //   flex: 1,
              //   child: Container(
              //     alignment: Alignment.center,
              //     color: Colors.orange,
              //     child: Text(
              //       'orange',
              //       textAlign: TextAlign.center,
              //     ),
              //   ),
              // ),
              // Expanded(
              //   flex: 1,
              //   child: Container(
              //     alignment: Alignment.center,
              //     color: Colors.yellow,
              //     child: Text(
              //       'yellow',
              //       textAlign: TextAlign.center,
              //     ),
              //   ),
              // ),
              // Expanded(
              //     child: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: <Widget>[
              //     Text(
              //       '$counter',
              //       style: TextStyle(color: Colors.white),
              //       textAlign: TextAlign.center,
              //     ),
              //     FloatingActionButton(
              //       onPressed: () {
              //         setState(() {
              //           counter += 1;
              //         });
              //       },
              //       child: Icon(Icons.add),
              //       backgroundColor: Colors.grey[800],
              //     )
              //   ],
              // )),

              Visibility(
                visible: true,
                child: Expanded(
                  flex: 8,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
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
              ),
              Visibility(
                  visible: isStopwatchOn ? false : true,
                  child: Flexible(
                      flex: 14,
                      fit: FlexFit.tight,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TimerElevatedButton(
                              timer: this.timers[0].getTimer(),
                              startStopWatch: () async {
                                startStopwatch(0);
                              },
                            ),
                            TimerElevatedButton(
                              timer: this.timers[1].getTimer(),
                              startStopWatch: () {
                                startStopwatch(1);
                              },
                            )
                          ],
                        ),
                      ))),
              Visibility(
                visible: isStopwatchOn ? false : true,
                child: Flexible(
                    flex: 14,
                    fit: FlexFit.tight,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TimerElevatedButton(
                            timer: this.timers[2].getTimer(),
                            startStopWatch: () {
                              startStopwatch(2);
                            },
                          ),
                          TimerElevatedButton(
                            timer: this.timers[3].getTimer(),
                            startStopWatch: () {
                              startStopwatch(3);
                            },
                          ),
                        ],
                      ),
                    )),
              ),
              Visibility(
                visible: isStopwatchOn ? false : true,
                child: Flexible(
                  flex: 14,
                  fit: FlexFit.tight,
                  child: Container(
                      margin: EdgeInsets.fromLTRB(5, 5, 5, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TimerElevatedButton(
                            timer: this.timers[4].getTimer(),
                            startStopWatch: () {
                              startStopwatch(4);
                            },
                          ),
                          TimerElevatedButton(
                            timer: this.timers[5].getTimer(),
                            startStopWatch: () {
                              startStopwatch(5);
                            },
                          )
                        ],
                      )),
                ),
              ),
              Visibility(
                  visible: isStopwatchOn ? true : false,
                  child: Expanded(
                    flex: 21,
                    child: Container(
                        alignment: Alignment.center,
                        child: (Text(
                          "$timerOn",
                          style: TextStyle(color: Colors.white, fontSize: 60),
                        ))
                        // Countdown(
                        //   // controller: _controller,
                        //   seconds: this.timerOnInSeconds,
                        //   build: (_, double time) => Text(
                        //     TimerEntity(time.toInt()).getTimer(),
                        //     style: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 60,
                        //     ),
                        //     textAlign: TextAlign.center,
                        //   ),
                        //   interval: Duration(milliseconds: 100),
                        //   onFinished: () {
                        //     setState(() {
                        //       this.isStopwatchOn = false;
                        //     });
                        //   },
                        // ),
                        ),
                  )),
              Visibility(
                visible: isStopwatchOn ? true : false,
                child: Expanded(
                  flex: 21,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _timer.cancel();
                          this.isStopwatchOn = false;
                          if (reps[0] != true) {
                            pressRepButton(whichRepButtonIsPressed() + 1);
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[900],
                      ),
                      child: Text(
                        'STOP',
                        style: TextStyle(fontSize: 40),
                      )),
                ),
              ),
            ]
            // timers.map((timer) => TimerCard(timer: timer)).toList(),
            ));
  }
}
