import 'package:shared_preferences/shared_preferences.dart';

class PersistenceManager {
  // Obtain shared preferences.
  static late SharedPreferences prefs;

  static configureSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }
}
