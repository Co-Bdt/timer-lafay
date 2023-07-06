import 'package:flutter/material.dart';
import 'package:stopwatch_lafay/models/timer_entity.dart';
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
      height: 80,
      margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
      child: ElevatedButton(
          onPressed: () async {
            final Duration result = await showDialog(
                context: context,
                builder: (context) {
                  return TimerPickerDialog(widget.timerNumber, _timerDuration);
                });
            setState(() {
              _timerDuration = result;
            });
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[800],
              alignment: Alignment.centerLeft,
              fixedSize: Size.infinite),
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
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  Text(
                    TimerEntity(_timerDuration.inSeconds.toDouble()).getTimer(),
                    style: TextStyle(fontSize: 16, color: Colors.amber[300]),
                  ),
                ],
              ),
              const Icon(
                Icons.edit_outlined,
                size: 30,
              )
            ],
          )),
    );
  }
}
