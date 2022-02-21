import 'package:flutter/material.dart';

class TimerElevatedButton extends StatelessWidget {
  final String timer;
  final Function startStopWatch;

  TimerElevatedButton({this.timer, this.startStopWatch});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: ElevatedButton(
            onPressed: () {
              startStopWatch();
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 46, 139, 87),
              textStyle: TextStyle(fontSize: 30),
            ),
            child: Text(this.timer)),
      ),
    );
  }
}
