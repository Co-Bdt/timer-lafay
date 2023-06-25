import 'package:flutter/material.dart';
import 'package:stopwatch_lafay/pages/home.dart';
import 'package:stopwatch_lafay/pages/settings.dart';

void main() {
  runApp(MaterialApp(
    // home: Home(),
    initialRoute: '/home',
    routes: {
      // '/': (context) => Loading(),
      '/home': (context) => const Home(),
      '/settings': (context) => const Settings(),
      // '/timer_picker': (context) => TimerPickerDialog(),
    },
  ));
}

// TODO :
// prevent the app to be in landscape mode