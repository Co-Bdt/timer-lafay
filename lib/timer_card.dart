import 'package:flutter/material.dart';
import 'services/timer_entity.dart';

class TimerCard extends StatelessWidget {
  final TimerEntity timer;
  TimerCard({this.timer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              color: Colors.green[600],
              padding: EdgeInsets.all(12),
              child: Text(
                timer.getTimer(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[900],
                ),
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }
}
