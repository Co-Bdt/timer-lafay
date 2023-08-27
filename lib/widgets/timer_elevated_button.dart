import 'package:flutter/material.dart';

class TimerElevatedButton extends StatelessWidget {
  final String timer;
  final Function startStopWatch;

  const TimerElevatedButton(
      {super.key, required this.timer, required this.startStopWatch});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: ElevatedButton(
            onPressed: () {
              startStopWatch();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF30905a),
                textStyle: const TextStyle(fontSize: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                )),
            child: Text(timer,
                style: const TextStyle(fontWeight: FontWeight.w500))),
      ),
    );
  }
}
