import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:stopwatch_lafay/screens/home.dart';
import 'package:stopwatch_lafay/utils/persistence_manager.dart';
import 'package:stopwatch_lafay/utils/ring_manager.dart';

Widget createHomeScreen() {
  return const MaterialApp(
    home: Home(),
  );
}

void main() async {
  SharedPreferences.setMockInitialValues({});
  await PersistenceManager.configureSharedPreferences();
  RingManager.configureAudioSession();

  group('Home screen widget tests', () {
    testWidgets('Tap on rep button color test', (widgetTester) async {
      // renders the home widget
      await widgetTester.pumpWidget(createHomeScreen());

      // find elevated button with text '0'
      final repBtn0Finder = find.widgetWithText(ElevatedButton, '0');
      // expect to find one widget
      expect(repBtn0Finder, findsOneWidget);

      // get the background color of the button
      var repBtn0 = widgetTester.widget<ElevatedButton>(repBtn0Finder);
      var btn0bgColor =
          repBtn0.style!.backgroundColor!.resolve(<MaterialState>{});

      // expect the background color to be amber 600
      expect(btn0bgColor, Colors.amber[600]);

      // find elevated button with text '1'
      final repBtn1Finder = find.widgetWithText(ElevatedButton, '1');
      // expect to find one widget
      expect(repBtn1Finder, findsOneWidget);

      // get the background color of the button
      var repBtn1 = widgetTester.widget<ElevatedButton>(repBtn1Finder);
      var btn1bgColor =
          repBtn1.style!.backgroundColor!.resolve(<MaterialState>{});

      // expect the background color to be green
      expect(btn1bgColor, const Color(0xFF2E8B57));

      // tap on the button '1'
      await widgetTester.tap(repBtn1Finder);
      // wait for the animation to finish
      await widgetTester.pumpAndSettle();

      // get the background color of the first button
      repBtn0 = widgetTester.widget<ElevatedButton>(repBtn0Finder);
      btn0bgColor = repBtn0.style!.backgroundColor!.resolve(<MaterialState>{});

      // expect the background color to be green
      expect(btn0bgColor, const Color(0xFF2E8B57));

      // get the background color of the second button
      repBtn1 = widgetTester.widget<ElevatedButton>(repBtn1Finder);
      btn1bgColor = repBtn1.style!.backgroundColor!.resolve(<MaterialState>{});

      // expect the background color to be amber 600
      expect(btn1bgColor, Colors.amber[600]);
    });

    testWidgets('Tap on a timer decrement rep number by 1',
        (widgetTester) async {
      // renders the home widget
      await widgetTester.pumpWidget(createHomeScreen());

      // find rep button with text '6'
      final repBtn6Finder = find.widgetWithText(ElevatedButton, '6');
      // expect to find one widget
      expect(repBtn6Finder, findsOneWidget);

      // get the background color of the button '6'
      var repBtn6 = widgetTester.widget<ElevatedButton>(repBtn6Finder);
      var btn6bgColor =
          repBtn6.style!.backgroundColor!.resolve(<MaterialState>{});
      // expect the background color to be green
      expect(btn6bgColor, const Color(0xFF2E8B57));

      // tap on the button '6'
      await widgetTester.tap(repBtn6Finder);
      // wait for the animation to finish
      await widgetTester.pumpAndSettle();

      // get the background color of the button '6'
      repBtn6 = widgetTester.widget<ElevatedButton>(repBtn6Finder);
      btn6bgColor = repBtn6.style!.backgroundColor!.resolve(<MaterialState>{});
      // expect the background color to be amber 600
      expect(btn6bgColor, Colors.amber[600]);

      // find rep button with text '5'
      final repBtn5Finder = find.widgetWithText(ElevatedButton, '5');
      // expect to find one widget
      expect(repBtn5Finder, findsOneWidget);

      // get the background color of the button '5'
      var repBtn5 = widgetTester.widget<ElevatedButton>(repBtn5Finder);
      var btn5bgColor =
          repBtn5.style!.backgroundColor!.resolve(<MaterialState>{});
      // expect the background color to be green
      expect(btn5bgColor, const Color(0xFF2E8B57));

      // find timer button with text '25"'
      final timerBtn25SecFinder = find.widgetWithText(ElevatedButton, '25"');
      // expect to find one widget
      expect(timerBtn25SecFinder, findsOneWidget);

      // tap on the button '25"'
      await widgetTester.tap(timerBtn25SecFinder);
      // wait for the animation to finish
      await widgetTester.pumpAndSettle();

      // get the background color of the button '6'
      repBtn6 = widgetTester.widget<ElevatedButton>(repBtn6Finder);
      btn6bgColor = repBtn6.style!.backgroundColor!.resolve(<MaterialState>{});
      // expect the background color to be green
      expect(btn6bgColor, const Color(0xFF2E8B57));

      // get the background color of the button '5'
      repBtn5 = widgetTester.widget<ElevatedButton>(repBtn5Finder);
      btn5bgColor = repBtn5.style!.backgroundColor!.resolve(<MaterialState>{});
      // expect the background color to be amber 600
      expect(btn5bgColor, Colors.amber[600]);
    });
  });
}
