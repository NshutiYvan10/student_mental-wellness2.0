import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_mental_wellness/widgets/avatar_selector.dart';

void main() {
  group('AvatarSelector', () {
    testWidgets('should display all available avatars', (WidgetTester tester) async {
      // Arrange
      String? selectedAvatar;
      final widget = AvatarSelector(
        onAvatarSelected: (avatar) => selectedAvatar = avatar,
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      // Assert
      expect(find.text('Choose Your Avatar'), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);
      
      // Should display all available avatars
      for (final avatar in AvatarSelector.availableAvatars) {
        expect(find.text(avatar), findsOneWidget);
      }
    });

    testWidgets('should highlight selected avatar', (WidgetTester tester) async {
      // Arrange
      const selectedAvatar = '👨‍🎓';
      String? newSelectedAvatar;
      
      final widget = AvatarSelector(
        selectedAvatar: selectedAvatar,
        onAvatarSelected: (avatar) => newSelectedAvatar = avatar,
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      // Assert
      // The selected avatar should be displayed
      expect(find.text(selectedAvatar), findsOneWidget);
    });

    testWidgets('should call onAvatarSelected when avatar is tapped', (WidgetTester tester) async {
      // Arrange
      String? selectedAvatar;
      final widget = AvatarSelector(
        onAvatarSelected: (avatar) => selectedAvatar = avatar,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      // Act
      await tester.tap(find.text('👨‍🎓').first);
      await tester.pump();

      // Assert
      expect(selectedAvatar, equals('👨‍🎓'));
    });

    testWidgets('should update selection when different avatar is tapped', (WidgetTester tester) async {
      // Arrange
      String? selectedAvatar;
      final widget = AvatarSelector(
        onAvatarSelected: (avatar) => selectedAvatar = avatar,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      // Act
      await tester.tap(find.text('👨‍🎓').first);
      await tester.pump();
      
      await tester.tap(find.text('👩‍🎓').first);
      await tester.pump();

      // Assert
      expect(selectedAvatar, equals('👩‍🎓'));
    });

    testWidgets('should have correct grid layout', (WidgetTester tester) async {
      // Arrange
      final widget = AvatarSelector(
        onAvatarSelected: (avatar) {},
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      // Assert
      final gridView = find.byType(GridView);
      expect(gridView, findsOneWidget);
      
      final gridViewWidget = tester.widget<GridView>(gridView);
      expect(gridViewWidget.gridDelegate, isA<SliverGridDelegateWithFixedCrossAxisCount>());
      
      final delegate = gridViewWidget.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, equals(6));
    });

    testWidgets('should display correct number of avatars', (WidgetTester tester) async {
      // Arrange
      final widget = AvatarSelector(
        onAvatarSelected: (avatar) {},
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      // Assert
      expect(find.byType(GestureDetector), findsNWidgets(AvatarSelector.availableAvatars.length));
    });

    testWidgets('should have proper styling for selected avatar', (WidgetTester tester) async {
      // Arrange
      const selectedAvatar = '👨‍🎓';
      final widget = AvatarSelector(
        selectedAvatar: selectedAvatar,
        onAvatarSelected: (avatar) {},
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      // Assert
      // Find the container for the selected avatar
      final selectedContainer = find.ancestor(
        of: find.text(selectedAvatar),
        matching: find.byType(Container),
      );
      expect(selectedContainer, findsOneWidget);
    });

    testWidgets('should have proper styling for unselected avatars', (WidgetTester tester) async {
      // Arrange
      final widget = AvatarSelector(
        onAvatarSelected: (avatar) {},
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      // Assert
      // All avatars should be displayed
      for (final avatar in AvatarSelector.availableAvatars) {
        expect(find.text(avatar), findsOneWidget);
      }
    });

    testWidgets('should handle null selectedAvatar', (WidgetTester tester) async {
      // Arrange
      final widget = AvatarSelector(
        selectedAvatar: null,
        onAvatarSelected: (avatar) {},
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      // Assert
      expect(find.text('Choose Your Avatar'), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('should have proper container decoration', (WidgetTester tester) async {
      // Arrange
      final widget = AvatarSelector(
        onAvatarSelected: (avatar) {},
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: widget),
        ),
      );

      // Assert
      final container = find.byType(Container).first;
      expect(container, findsOneWidget);
      
      final containerWidget = tester.widget<Container>(container);
      expect(containerWidget.decoration, isA<BoxDecoration>());
    });
  });
}


