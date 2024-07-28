import 'package:flutter/material.dart';
import 'package:timer_lafay/utils/extensions.dart';

import '../utils/persistence_manager.dart';

// ignore: must_be_immutable
class SettingsBehaviourParameter extends StatefulWidget {
  final String name;
  final String description;
  final String persistenceKey;
  bool isParameterActive;
  final VoidCallback callback;

  SettingsBehaviourParameter(this.name, this.description, this.persistenceKey,
      this.isParameterActive, this.callback,
      {super.key});

  @override
  State<SettingsBehaviourParameter> createState() =>
      _SettingsBehaviourParameterState();
}

class _SettingsBehaviourParameterState
    extends State<SettingsBehaviourParameter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.grey[800], borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 4),
                child: Text(
                  widget.name,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 1),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    widget.description,
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ),
              ),
            ],
          ),
          Checkbox(
              value:
                  (PersistenceManager.get(widget.persistenceKey)).toBoolean(),
              side: WidgetStateBorderSide.resolveWith(
                  (states) => const BorderSide(color: Colors.white)),
              activeColor: Colors.grey[800],
              checkColor: Colors.amber[600],
              onChanged: (bool? checkboxChanged) async {
                setState(() {
                  widget.isParameterActive = checkboxChanged!;
                });
                // Toggle the parameter
                widget.callback();
              })
        ],
      ),
    );
  }
}
