import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stopwatch_lafay/screens/home.dart';
import 'package:stopwatch_lafay/screens/settings.dart';
import 'package:stopwatch_lafay/utils/persistence_manager.dart';
import 'package:stopwatch_lafay/utils/ring_manager.dart';
import 'package:stopwatch_lafay/utils/vibration_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  PersistenceManager.configureSharedPreferences();

  RingManager.configureAudioSession();
  RingManager.loadRing();

  VibrationManager.configureVibration();

  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => const Home(),
      '/settings': (context) => const Settings(),
    },
  ));
}
