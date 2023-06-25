import 'package:flutter/material.dart';
import 'package:stopwatch_lafay/services/timer_picker_button.dart';

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

  bool checkboxVibrate = false;

  @override
  Widget build(BuildContext context) {
    // extract the arguments from the current ModalRoute setting and cast them as Home
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          'Réglages',
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
                'Chronomètres',
                style: TextStyle(color: Colors.amber[300], fontSize: 17),
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
                'Comportement',
                style: TextStyle(color: Colors.amber[300], fontSize: 17),
              ),
            ),
            Container(
              height: 80,
              margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (args['arg1']) {
                        checkboxVibrate = checkboxVibrate;
                      } else {
                        print(
                            'L\'appareil ne prend pas en charge les vibrations');
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      alignment: Alignment.centerLeft,
                      fixedSize: Size.infinite),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: Text(
                              'Vibrer',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Text(
                            'Faire vibrer à la fin du minuteur',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                        ],
                      ),
                      Checkbox(
                          value: checkboxVibrate,
                          activeColor: Colors.grey[850],
                          checkColor: Colors.amber[300],
                          onChanged: (bool? checkboxChanged) {
                            setState(() {
                              checkboxVibrate = checkboxChanged!;
                            });
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
