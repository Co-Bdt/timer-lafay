import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stopwatch_lafay/screens/home.dart';
import 'package:stopwatch_lafay/screens/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false, // to be removed in production
        initialRoute: '/home',
        routes: {
          '/home': (context) => const Home(),
          '/settings': (context) => const Settings(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.dark(
            primary: Colors.white,
            secondary: Colors.amber[600]!,
            onPrimary: Colors.white, // text color
          ),
        )),
  );
}
