import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stopwatch_lafay/utils/persistence_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  group('Test persistence manager class', () {
    // test the initialization of SharedPreferences instance
    test(
        'PersistenceManager - SharedPreferences instance should be initialized',
        () async {
      // test the initialization of SharedPreferences instance
      expect(PersistenceManager.sharedPreferencesInstance, isNull);
      await PersistenceManager.initializeSharedPreferences();
      expect(PersistenceManager.sharedPreferencesInstance, isNotNull);
    });

    // test the store() function
    test('PersistenceManager - store() function should persist a value',
        () async {
      await PersistenceManager.initializeSharedPreferences();
      // store a value
      PersistenceManager.store('key', 'value');
      // get the value
      final value = PersistenceManager
          .sharedPreferencesInstance?.sharedPreferences
          .get('key');
      // expect the value to be 'value'
      expect(value, 'value');
    });

    // test the get() function
    test('PersistenceManager - get() function should return a value', () async {
      await PersistenceManager.initializeSharedPreferences();
      // store a value
      PersistenceManager.sharedPreferencesInstance?.sharedPreferences
          .setString('key', 'value');
      // get the value
      final value = PersistenceManager.get('key');
      // expect the value to be 'value'
      expect(value, 'value');
    });
  });
}
