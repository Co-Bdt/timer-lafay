import 'package:vibration/vibration.dart';

class VibrationManager {
  // Object to handle device's vibration
  static late bool hasVibration;
  // Static Vibration vibration = Vibration();
  static late bool hasAmplitudeControl;
  // Store the vibration status
  static bool isVibrationActive = false;

  static configureVibration() async {
    // Check if the device has vibration capabilities
    hasVibration = (await Vibration.hasVibrator())!;
    // Check if the device has amplitude control
    hasAmplitudeControl = (await Vibration.hasAmplitudeControl())!;
  }
}
