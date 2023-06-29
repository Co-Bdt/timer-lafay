import 'package:flutter/material.dart';
import 'package:stopwatch_lafay/screens/home.dart';
import 'package:stopwatch_lafay/screens/settings.dart';

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

// prevent the app to be in landscape mode
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SystemChrome.setPreferredOrientations(
//       [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
//   runApp(MaterialApp(
//     home: Home(),
//   ));