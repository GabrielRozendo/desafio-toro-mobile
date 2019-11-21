import 'package:flutter_test/flutter_test.dart';
import 'package:toro_investimentos/utils/date_utils.dart';

void main() {
  group('Datetime differences', () {
    test('Value should be "agora!"', () {
      expect(DateUtils.durationInString(DateTime.now()), 'agora!');
    });
    test('Value should be "1 seg. atrás"', () {
      final oneSecondAgo = DateTime.now().add(Duration(seconds: -1));
      expect(DateUtils.durationInString(oneSecondAgo), '1 seg. atrás');
    });

    test('Value should be "59 seg. atrás"', () {
      final manySecondsAgo = DateTime.now().add(Duration(seconds: -59));
      expect(DateUtils.durationInString(manySecondsAgo), '59 seg. atrás');
    });

    test('Value should be "1 min. atrás"', () {
      final oneMinuteAgo = DateTime.now().add(Duration(seconds: -60));
      expect(DateUtils.durationInString(oneMinuteAgo), '1 min. atrás');
    });

    test('Value should be "1 min. atrás"', () {
      final oneMinuteAgo = DateTime.now().add(Duration(minutes: -1));
      expect(DateUtils.durationInString(oneMinuteAgo), '1 min. atrás');
    });

    test('Value should be "59 min. atrás"', () {
      final manyMinutesAgo = DateTime.now().add(Duration(minutes: -59));
      expect(DateUtils.durationInString(manyMinutesAgo), '59 min. atrás');
    });

    test('Value should be "Há muito tempo..."', () {
      final longTimeAgo = DateTime.now().add(Duration(hours: -1));
      expect(DateUtils.durationInString(longTimeAgo), 'Há muito tempo...');
    });
  });
}
