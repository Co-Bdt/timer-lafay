class TimerEntity {
  num duration;

  TimerEntity(int duration) {
    this.duration = duration;
  }

  String getTimer() {
    num minutes = this.duration ~/ 60;
    num minutesDouble = this.duration / 60;
    num minutesDifference = minutesDouble - minutes;

    if (minutes >= 1) {
      //higher than a min
      if (minutesDifference != 0) {
        return minutes.toString() +
            '\'' +
            ((minutesDifference) * 60).toInt().toString() +
            '\"';
      } else {
        return minutes.toString() + '\'';
      }
    } else {
      //lower than a min
      return this.duration.toString() + '\"';
    }
  }
}
