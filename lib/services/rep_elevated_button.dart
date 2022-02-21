import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RepElevatedButton extends StatefulWidget {
  final String number;
  bool press;
  final Function pressRepButton;

  RepElevatedButton({this.number, this.press, this.pressRepButton});

  @override
  _RepElevatedButton createState() => _RepElevatedButton();
}

class _RepElevatedButton extends State<RepElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width / 7) - (10 / 7),
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: ElevatedButton(
          onPressed: () {
            widget.pressRepButton();
          },
          style: ElevatedButton.styleFrom(
              primary: widget.press
                  ? Colors.amber[300]
                  : Color.fromARGB(255, 46, 139, 87),
              textStyle: TextStyle(fontSize: 30),
              // minimumSize:
              // Size((MediaQuery.of(context).size.width / 6) - 59, 0),
              padding: EdgeInsets.all(10)),
          child: Text(widget.number)),
    );
  }
}
