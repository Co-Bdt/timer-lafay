import 'package:flutter/material.dart';
import 'package:stopwatch_lafay/services/timer_entity.dart';
import 'package:stopwatch_lafay/services/timer_picker_stateful_dialog.dart';

class TimerPickerButton extends StatefulWidget {
  final num timerNumber;
  Duration timerDuration;

  TimerPickerButton(this.timerNumber, this.timerDuration);

  @override
  _TimerPickerButtonState createState() => _TimerPickerButtonState();
}

class _TimerPickerButtonState extends State<TimerPickerButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
      child: ElevatedButton(
          onPressed: () async {
            final Duration result = await showDialog(
                context: context,
                builder: (context) {
                  return TimerPickerDialog(
                      widget.timerNumber, widget.timerDuration);
                });
            if (result != null) {
              setState(() {
                widget.timerDuration = result;
              });
            }
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.grey[800],
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
                      'Chrono ${widget.timerNumber}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Text(
                    TimerEntity(widget.timerDuration.inSeconds).getTimer(),
                    style: TextStyle(fontSize: 16, color: Colors.amber[300]),
                  ),
                ],
              ),
              Icon(
                Icons.edit_outlined,
                size: 30,
              )
            ],
          )),
    );
  }
}
