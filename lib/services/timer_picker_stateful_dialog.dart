import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';

class TimerPickerDialog extends StatefulWidget {
  final num timerNumber;
  Duration timerDuration;
  bool textVisible = false;

  TimerPickerDialog(this.timerNumber, this.timerDuration);

  @override
  _TimerPickerDialogState createState() => _TimerPickerDialogState();
}

class _TimerPickerDialogState extends State<TimerPickerDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Future<void> showInformationDialog(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return StatefulBuilder(builder: (context, setState) {
  //           return AlertDialog(
  //             content: Form(
  //               key: _formKey,
  //               child: DurationPicker(
  //                   duration: duration,
  //                   onChange: (val) {
  //                     setState(() {
  //                       duration = val;
  //                     });
  //                   }),
  //             ),
  //             title: Text('Stateful Dialog'),
  //             actions: <Widget>[
  //               InkWell(
  //                 child: Text('OK   '),
  //                 onTap: () {
  //                   if (_formKey.currentState.validate()) {
  //                     // Do something like updating SharedPreferences or User Settings etc.
  //                     Navigator.of(context).pop();
  //                   }
  //                 },
  //               ),
  //             ],
  //           );
  //         });
  //       });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Container(
  //       child: Center(
  //         child: ElevatedButton(
  //             style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
  //             onPressed: () async {
  //               await showInformationDialog(context);
  //             },
  //             child: Text(
  //               "Stateful Dialog",
  //               style: TextStyle(color: Colors.black, fontSize: 16),
  //             )),
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        content: Form(
          key: _formKey,
          child: DurationPicker(
            onChange: (val) {
              setState(() {
                widget.timerDuration = val;
              });
            },
            duration: widget.timerDuration,
            baseUnit: BaseUnit.second,
          ),
        ),
        title: Text('Chrono ${widget.timerNumber}'),
        actions: <Widget>[
          Center(
            child: Visibility(
              visible: widget.textVisible,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              replacement: SizedBox.shrink(),
              child: Text(
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
                child: Text('OK'),
                onPressed: () {
                  if (widget.timerDuration.inSeconds >= 5) {
                    Navigator.of(context).pop(widget.timerDuration);
                  } else {
                    setState(() {
                      widget.textVisible = true;
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
