import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesSingleton {
  static SharedPreferencesSingleton? _instance;
  final SharedPreferences _sharedPreferences;

  static Future<SharedPreferencesSingleton> getInstance() async {
    if (_instance == null) {
      final sharedPreferences = await SharedPreferences.getInstance();
      _instance = SharedPreferencesSingleton._(sharedPreferences);
    }
    return _instance!;
  }

  SharedPreferencesSingleton._(SharedPreferences sharedPreferences)
      : _sharedPreferences = sharedPreferences;

  SharedPreferences get sharedPreferences => _sharedPreferences;
}
