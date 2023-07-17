import 'package:test/test.dart';
import 'package:stopwatch_lafay/models/timer_entity.dart';

void main() {
  group('Test getTimer function', () {
    test('30 seconds should return 30"', () {
      TimerEntity timerEntity = TimerEntity(30);
      expect(timerEntity.getTimer(), '30"');
    });

    test('1 minute and 30 seconds should return 1\'30"', () {
      TimerEntity timerEntity = TimerEntity(90);
      expect(timerEntity.getTimer(), '1\'30"');
    });

    test('5 minute should return 5\'', () {
      TimerEntity timerEntity = TimerEntity(300);
      expect(timerEntity.getTimer(), '5\'');
    });
  });
}
