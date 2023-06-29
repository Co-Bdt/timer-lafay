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

  late Duration _timerDuration;
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
        title: Text('Chrono ${widget.timerNumber}'),
        actions: <Widget>[
          Center(
            child: Visibility(
              visible: textVisible,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              replacement: const SizedBox.shrink(),
              child: const Text(
                'Le chrono doit être d\'au moins 5 secondes',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () {
                  if (_timerDuration.inSeconds >= 5) {
                    Navigator.of(context).pop(_timerDuration);
                  } else {
                    setState(() {
                      textVisible = true;
                    });
                  }
                },
              ),
            ],
          ),
        ],
      );
    });
  }
}
