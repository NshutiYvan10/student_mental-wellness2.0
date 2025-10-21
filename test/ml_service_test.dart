import 'package:flutter_test/flutter_test.dart';
import 'package:student_mental_wellness/services/ml_service.dart';

void main() {
  group('MlService', () {
    test('analyzeSentiment returns positive score for positive text', () async {
      final ml = MlService();
      final score = await ml.analyzeSentiment('I am very happy and grateful. This is amazing!');
      expect(score, greaterThan(0));
    });

    test('analyzeSentiment returns negative score for negative text', () async {
      final ml = MlService();
      final score = await ml.analyzeSentiment('I feel sad, stressed, and overwhelmed.');
      expect(score, lessThan(0));
    });
  });
}



