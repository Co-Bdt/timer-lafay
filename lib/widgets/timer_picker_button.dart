import 'package:flutter/material.dart';
import 'package:stopwatch_lafay/models/timer_entity.dart';
import 'package:stopwatch_lafay/utils/persistence_manager.dart';
import 'package:stopwatch_lafay/widgets/timer_picker_stateful_dialog.dart';

class TimerPickerButton extends StatefulWidget {
  final num timerNumber;
  final Duration timerDuration;

  const TimerPickerButton(this.timerNumber, this.timerDuration, {super.key});

  @override
  TimerPickerButtonState createState() => TimerPickerButtonState();
}

class TimerPickerButtonState extends State<TimerPickerButton> {
  late Duration _timerDuration;

  @override
  void initState() {
    super.initState();
    _timerDuration = widget.timerDuration;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
      color: Colors.grey[800],
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Text(
                  'Timer ${widget.timerNumber}',
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              Text(
                TimerEntity(_timerDuration.inSeconds).getTimer(),
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.amber[600],
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          IconButton(
            onPressed: () async {
              final Duration? result = await showDialog(
                  context: context,
                  builder: (context) {
                    return TimerPickerDialog(
                        widget.timerNumber, _timerDuration);
                  });
              if (result != null) {
                setState(() {
                  _timerDuration = result;
                });
                PersistenceManager.prefs
                    .setInt('timer${widget.timerNumber}', result.inSeconds);
              }
            },
            icon: const Icon(
              Icons.edit_outlined,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
