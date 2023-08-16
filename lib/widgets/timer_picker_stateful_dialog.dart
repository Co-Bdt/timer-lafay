import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';

class TimerPickerDialog extends StatefulWidget {
  final num timerNumber;
  final Duration timerDuration;

  const TimerPickerDialog(this.timerNumber, this.timerDuration, {super.key});

  @override
  TimerPickerDialogState createState() => TimerPickerDialogState();
}

class TimerPickerDialogState extends State<TimerPickerDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Duration _timerDuration = Duration.zero;
  bool textVisible = false;

  @override
  void initState() {
    super.initState();
    _timerDuration = widget.timerDuration;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        backgroundColor: Colors.grey[800],
        content: Form(
          key: _formKey,
          child: DurationPicker(
            onChange: (val) {
              setState(() {
                _timerDuration = val;
              });
            },
            duration: _timerDuration,
            baseUnit: BaseUnit.second,
          ),
        ),
        title: Text('Timer ${widget.timerNumber}',
            style: const TextStyle(color: Colors.white)),
        actions: <Widget>[
          Center(
            child: Visibility(
              visible: textVisible,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              replacement: const SizedBox.shrink(),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text(
                  'The stopwatch must be at least 7 seconds long',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              if (_timerDuration.inSeconds >= 7) {
                Navigator.of(context).pop(_timerDuration);
              } else {
                setState(() {
                  textVisible = true;
                });
              }
            },
          ),
        ],
      );
    });
  }
}
