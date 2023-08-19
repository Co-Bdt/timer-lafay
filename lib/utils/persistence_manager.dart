import 'package:timer_lafay/utils/shared_preferences_singleton.dart';

class PersistenceManager {
  static SharedPreferencesSingleton? sharedPreferencesInstance;

  static initializeSharedPreferences() async {
    sharedPreferencesInstance = await SharedPreferencesSingleton.getInstance();
  }

  // Function to store a value in shared preferences
  static void store(String key, String value) async {
    sharedPreferencesInstance?.sharedPreferences.setString(key, value);
  }

  // Function to get a value from shared preferences
  static String get(String key) {
    return sharedPreferencesInstance?.sharedPreferences.getString(key) ?? "";
  }
}
