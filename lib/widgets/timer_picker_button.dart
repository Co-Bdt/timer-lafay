import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:timer_lafay/models/timer_entity.dart';
import 'package:timer_lafay/utils/persistence_manager.dart';

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
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.grey[800], borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                child: Text(
                  'Timer ${widget.timerNumber}',
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 1),
                child: Text(
                  TimerEntity(_timerDuration.inSeconds).getTimer(),
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.amber[600],
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          IconButton(
            tooltip: 'Edit timer',
            icon: const Icon(
              Icons.edit_outlined,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () async {
              var resultingDuration = await showDurationPicker(
                context: context,
                initialTime: _timerDuration,
                baseUnit: BaseUnit.second,
              );

              if (!mounted) return;
              if (resultingDuration != null) {
                if (resultingDuration.inSeconds < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Duration must be at least 6 seconds',
                      style: TextStyle(
                          color: Colors.red[700], fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.grey[700],
                  ));
                  resultingDuration = const Duration(seconds: 6);
                }
                setState(() {
                  _timerDuration = resultingDuration!;
                });
                PersistenceManager.store('timer${widget.timerNumber}',
                    resultingDuration.inSeconds.toString());
              }
            },
          )
        ],
      ),
    );
  }
}
