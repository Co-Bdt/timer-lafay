import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:developer';
import 'package:stopwatch_lafay/pages/home.dart';
import 'package:stopwatch_lafay/pages/settings.dart';

void main() {
  String height = window.physicalSize.toString();
  log('height: $height');

  runApp(MaterialApp(
    // home: Home(),
    initialRoute: '/home',
    routes: {
      // '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/settings': (context) => Settings(),
      // '/timer_picker': (context) => TimerPickerDialog(),
    },
  ));
}

// TODO :
// empêcher de basculer l'appli en mode paysage