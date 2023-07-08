import 'package:flutter/material.dart';

class RepElevatedButton extends StatefulWidget {
  final String number;
  final bool? press;
  final Function pressRepButton;

  const RepElevatedButton(
      {super.key,
      required this.number,
      required this.press,
      required this.pressRepButton});

  @override
  RepElevatedButtonState createState() => RepElevatedButtonState();
}

class RepElevatedButtonState extends State<RepElevatedButton> {
  bool? press;

  @override
  void initState() {
    super.initState();
    press = widget.press;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width / 7) - (10 / 7),
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: ElevatedButton(
          onPressed: () {
            widget.pressRepButton();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: widget.press != null
                  ? widget.press == true
                      ? Colors.amber[600]
                      : const Color(0xFF2E8B57)
                  : Colors.amber[600],
              textStyle: const TextStyle(fontSize: 30),
              padding: const EdgeInsets.all(10)),
          child: Text(widget.number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ))),
    );
  }
}
