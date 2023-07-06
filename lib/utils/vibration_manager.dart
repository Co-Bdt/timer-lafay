import 'package:vibration/vibration.dart';

class VibrationManager {
  // object to handle device's vibration
  static late bool hasVibration;
  // static Vibration vibration = Vibration();
  static late bool hasAmplitudeControl;
  // booleans to check if the device has vibration capabilities
  static late bool hasCustomVibrationSupport;

  static configureVibration() async {
    // check if the device has vibration capabilities
    hasVibration = (await Vibration.hasVibrator())!;
    // check if the device has amplitude control
    hasAmplitudeControl = (await Vibration.hasAmplitudeControl())!;
    // check if the device has custom vibration support
    hasCustomVibrationSupport = (await Vibration.hasCustomVibrationsSupport())!;
  }
}
