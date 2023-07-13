class TimerEntity {
  int duration;

  TimerEntity(this.duration);

  String getTimer() {
    int minutes = (duration ~/ 60);
    double minutesDouble = (duration / 60);
    double minutesDifference = (minutesDouble - minutes);

    if (minutes >= 1) {
      //higher than a min
      if (minutesDifference != 0) {
        return '${removeDecimalZeroFormat(minutes)}\'${removeDecimalZeroFormat((minutesDifference * 60).toInt())}"';
      } else {
        return '${removeDecimalZeroFormat(minutes)}\'';
      }
    } else {
      //lower than a min
      return '${removeDecimalZeroFormat(duration)}"';
    }
  }

  String removeDecimalZeroFormat(int n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }
}
