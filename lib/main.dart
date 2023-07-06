import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stopwatch_lafay/screens/home.dart';
import 'package:stopwatch_lafay/screens/settings.dart';
import 'package:stopwatch_lafay/utilities/ring_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  RingManager.loadRing();

  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => const Home(),
      '/settings': (context) => const Settings(),
    },
  ));
}
