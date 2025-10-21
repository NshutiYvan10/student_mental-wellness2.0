import 'package:flutter_test/flutter_test.dart';
import 'package:student_mental_wellness/providers/mood_theme_provider.dart';
import 'package:student_mental_wellness/models/mood_entry.dart';

void main() {
  test('MoodThemeProvider updates theme based on mood', () {
    final provider = MoodThemeProvider();
    final initial = provider.state.primaryGradient;

    provider.updateMood(MoodType.veryHappy);
    final updated = provider.state.primaryGradient;

    expect(updated, isNot(initial));
  });
}



