import 'package:flutter/material.dart';
import 'package:stopwatch_lafay/utils/persistence_manager.dart';
import 'package:stopwatch_lafay/utils/vibration_manager.dart';
import 'package:stopwatch_lafay/widgets/timer_picker_button.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  List<Duration> durations = [
    const Duration(seconds: 25),
    const Duration(seconds: 60),
    const Duration(seconds: 90),
    const Duration(seconds: 120),
    const Duration(seconds: 180),
    const Duration(seconds: 240),
  ];

  bool isVibrationActive = false;

  @override
  Widget build(BuildContext context) {
    // extract the arguments from the current ModalRoute setting and cast them as Home
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 18),
              child: Text(
                'Stopwatches',
                style: TextStyle(color: Colors.amber[600], fontSize: 17),
              ),
            ),
            TimerPickerButton(1, durations[0]),
            TimerPickerButton(2, durations[1]),
            TimerPickerButton(3, durations[2]),
            TimerPickerButton(4, durations[3]),
            TimerPickerButton(5, durations[4]),
            TimerPickerButton(6, durations[5]),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 18),
              child: Text(
                'Behaviour',
                style: TextStyle(color: Colors.amber[600], fontSize: 17),
              ),
            ),
            Container(
              height: 70,
              margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // if (args['arg1']) {
                      //   isVibrationActive = isVibrationActive;
                      // } else {
                      // open dialog to inform the user that vibration is not available
                      // close dialog when the user taps on the OK button

                      // }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      alignment: Alignment.centerLeft,
                      fixedSize: Size.infinite),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: Text(
                              'Vibrate',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Text(
                            'Vibrate when the timer is over',
                            style:
                                TextStyle(fontSize: 14, color: Colors.white70),
                          ),
                        ],
                      ),
                      Checkbox(
                          value: PersistenceManager.prefs
                                  .getBool('isVibrationActive') ??
                              false,
                          side: MaterialStateBorderSide.resolveWith((states) =>
                              const BorderSide(color: Colors.white)),
                          activeColor: Colors.grey[850],
                          checkColor: Colors.amber[600],
                          onChanged: (bool? checkboxChanged) async {
                            if (VibrationManager.hasVibration) {
                              setState(() {
                                isVibrationActive = checkboxChanged!;
                              });
                              // Save the value to the shared preferences
                              PersistenceManager.prefs.setBool(
                                  'isVibrationActive', checkboxChanged!);
                              VibrationManager.isVibrating = checkboxChanged;
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                    backgroundColor: Colors.grey[900],
                                    title: const Text("Information",
                                        style: TextStyle(color: Colors.white)),
                                    content: const Text(
                                        "Vibration is not available on this device",
                                        style:
                                            TextStyle(color: Colors.white70)),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "OK",
                                            style: TextStyle(
                                                color: Colors.amber[600]),
                                          ))
                                    ]),
                              );
                            }
                          })
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
