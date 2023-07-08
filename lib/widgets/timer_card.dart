import 'package:flutter/material.dart';
import '../models/timer_entity.dart';

class TimerCard extends StatelessWidget {
  final TimerEntity timer;
  const TimerCard({super.key, required this.timer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              color: const Color(0xFF2E8B57),
              padding: const EdgeInsets.all(12),
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
