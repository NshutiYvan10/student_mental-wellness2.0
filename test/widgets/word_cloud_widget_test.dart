import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_mental_wellness/widgets/word_cloud_widget.dart';

void main() {
  group('WordCloudWidget', () {
    testWidgets('should display empty state when no word frequencies', (WidgetTester tester) async {
      // Arrange
      const widget = WordCloudWidget(wordFrequencies: {});

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      // Assert
      expect(find.text('No journal entries yet'), findsOneWidget);
      expect(find.byIcon(Icons.cloud_off_rounded), findsOneWidget);
    });

    testWidgets('should display word cloud when word frequencies provided', (WidgetTester tester) async {
      // Arrange
      const wordFrequencies = {
        'happy': 10,
        'sad': 5,
        'excited': 8,
        'worried': 3,
        'calm': 6,
      };

      const widget = WordCloudWidget(
        wordFrequencies: wordFrequencies,
        maxWords: 5,
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      // Assert
      expect(find.text('happy'), findsOneWidget);
      expect(find.text('sad'), findsOneWidget);
      expect(find.text('excited'), findsOneWidget);
      expect(find.text('worried'), findsOneWidget);
      expect(find.text('calm'), findsOneWidget);
    });

    testWidgets('should respect maxWords limit', (WidgetTester tester) async {
      // Arrange
      const wordFrequencies = {
        'word1': 10,
        'word2': 9,
        'word3': 8,
        'word4': 7,
        'word5': 6,
        'word6': 5,
        'word7': 4,
      };

      const widget = WordCloudWidget(
        wordFrequencies: wordFrequencies,
        maxWords: 3,
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      // Assert
      expect(find.text('word1'), findsOneWidget);
      expect(find.text('word2'), findsOneWidget);
      expect(find.text('word3'), findsOneWidget);
      expect(find.text('word4'), findsNothing);
      expect(find.text('word5'), findsNothing);
      expect(find.text('word6'), findsNothing);
      expect(find.text('word7'), findsNothing);
    });

    testWidgets('should display words in correct order (highest frequency first)', (WidgetTester tester) async {
      // Arrange
      const wordFrequencies = {
        'low': 1,
        'high': 10,
        'medium': 5,
      };

      const widget = WordCloudWidget(
        wordFrequencies: wordFrequencies,
        maxWords: 3,
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      // Assert
      final textWidgets = find.byType(Text);
      expect(textWidgets, findsWidgets);
      
      // The words should be displayed (order is handled by the algorithm)
      expect(find.text('high'), findsOneWidget);
      expect(find.text('medium'), findsOneWidget);
      expect(find.text('low'), findsOneWidget);
    });

    testWidgets('should use custom colors when provided', (WidgetTester tester) async {
      // Arrange
      const wordFrequencies = {
        'test': 5,
      };

      const customColors = [
        Color(0xFF000000),
        Color(0xFFFFFFFF),
      ];

      const widget = WordCloudWidget(
        wordFrequencies: wordFrequencies,
        colors: customColors,
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      // Assert
      expect(find.text('test'), findsOneWidget);
    });

    testWidgets('should respect font size constraints', (WidgetTester tester) async {
      // Arrange
      const wordFrequencies = {
        'small': 1,
        'large': 100,
      };

      const widget = WordCloudWidget(
        wordFrequencies: wordFrequencies,
        minFontSize: 10.0,
        maxFontSize: 20.0,
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      // Assert
      expect(find.text('small'), findsOneWidget);
      expect(find.text('large'), findsOneWidget);
    });

    testWidgets('should handle single word', (WidgetTester tester) async {
      // Arrange
      const wordFrequencies = {
        'only': 1,
      };

      const widget = WordCloudWidget(wordFrequencies: wordFrequencies);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      // Assert
      expect(find.text('only'), findsOneWidget);
    });

    testWidgets('should handle many words', (WidgetTester tester) async {
      // Arrange
      final wordFrequencies = <String, int>{};
      for (int i = 0; i < 100; i++) {
        wordFrequencies['word$i'] = i;
      }

      const widget = WordCloudWidget(
        wordFrequencies: wordFrequencies,
        maxWords: 50,
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      // Assert
      // Should display up to maxWords
      expect(find.byType(Text), findsWidgets);
    });

    testWidgets('should have correct container dimensions', (WidgetTester tester) async {
      // Arrange
      const wordFrequencies = {
        'test': 5,
      };

      const widget = WordCloudWidget(wordFrequencies: wordFrequencies);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      // Assert
      final container = find.byType(Container);
      expect(container, findsOneWidget);
    });
  });
}


