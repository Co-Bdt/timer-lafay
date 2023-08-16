import 'package:flutter/material.dart';
import 'package:stopwatch_lafay/models/timer_entity.dart';
import 'package:stopwatch_lafay/utils/persistence_manager.dart';
import 'package:stopwatch_lafay/utils/vibration_manager.dart';
import 'package:stopwatch_lafay/widgets/timer_picker_button.dart';
import 'package:stopwatch_lafay/utils/string_extension.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  bool isVibrationActive = false;
  List<TimerEntity> durations = [];

  void loadTimers(Map args) {
    if (args['timers'] != null) {
      for (var i = 0; i < args['timers'].length; i++) {
        durations.add(args['timers'][i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // extract the arguments from the current ModalRoute settings and pass them
    loadTimers(ModalRoute.of(context)!.settings.arguments as Map);

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
            TimerPickerButton(1, Duration(seconds: durations[0].duration)),
            TimerPickerButton(2, Duration(seconds: durations[1].duration)),
            TimerPickerButton(3, Duration(seconds: durations[2].duration)),
            TimerPickerButton(4, Duration(seconds: durations[3].duration)),
            TimerPickerButton(5, Duration(seconds: durations[4].duration)),
            TimerPickerButton(6, Duration(seconds: durations[5].duration)),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 0, 20),
              child: Text(
                'Behaviour',
                style: TextStyle(color: Colors.amber[600], fontSize: 17),
              ),
            ),
            Container(
              height: 70,
              padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
              color: Colors.grey[800],
              alignment: Alignment.centerLeft,
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
                          'Vibration',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'Vibrate when the timer is almost over',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                    ],
                  ),
                  Checkbox(
                      value: (PersistenceManager.get('isVibrationActive'))
                          .toBoolean(),
                      side: MaterialStateBorderSide.resolveWith(
                          (states) => const BorderSide(color: Colors.white)),
                      activeColor: Colors.grey[800],
                      checkColor: Colors.amber[600],
                      onChanged: (bool? checkboxChanged) async {
                        if (VibrationManager.hasVibration) {
                          setState(() {
                            isVibrationActive = checkboxChanged!;
                          });
                          // Save the value to the shared preferences
                          PersistenceManager.store(
                              'isVibrationActive', checkboxChanged.toString());
                          VibrationManager.isVibrationEnabled =
                              checkboxChanged!;
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                backgroundColor: Colors.grey[900],
                                title: const Text("Information",
                                    style: TextStyle(color: Colors.white)),
                                content: const Text(
                                    "Vibration is not available on this device",
                                    style: TextStyle(color: Colors.white70)),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "OK",
                                        style:
                                            TextStyle(color: Colors.amber[600]),
                                      ))
                                ]),
                          );
                        }
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
