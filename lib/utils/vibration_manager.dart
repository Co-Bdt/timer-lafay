import 'package:vibration/vibration.dart';

class VibrationManager {
  // object to handle device's vibration
  static late bool hasVibration;
  // static Vibration vibration = Vibration();
  static late bool hasAmplitudeControl;
  // store the vibration status
  static bool isVibrating = false;

  static configureVibration() async {
    // check if the device has vibration capabilities
    hasVibration = (await Vibration.hasVibrator())!;
    // check if the device has amplitude control
    hasAmplitudeControl = (await Vibration.hasAmplitudeControl())!;
  }
}
