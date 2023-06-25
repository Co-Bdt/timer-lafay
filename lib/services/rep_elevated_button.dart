import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RepElevatedButton extends StatefulWidget {
  final String number;
  bool? press;
  final Function pressRepButton;

  RepElevatedButton(
      {super.key, required this.number,
      required this.press,
      required this.pressRepButton});

  @override
  RepElevatedButtonState createState() => RepElevatedButtonState();
}

class RepElevatedButtonState extends State<RepElevatedButton> {
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
                      ? Colors.amber[300]
                      : const Color.fromARGB(255, 46, 139, 87)
                  : Colors.amber[300],
              textStyle: const TextStyle(fontSize: 30),
              // minimumSize:
              // Size((MediaQuery.of(context).size.width / 6) - 59, 0),
              padding: const EdgeInsets.all(10)),
          child: Text(widget.number)),
    );
  }
}
