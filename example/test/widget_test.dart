import 'package:easy_data_table/easy_data_table.dart';
import 'package:example/main.dart';
import 'package:example/person.dart'; // Make sure to import the Person class
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('EasyDataTable should render correctly',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the EasyDataTable widget renders correctly.
    expect(find.byType(EasyDataTable<Person>), findsOneWidget);
  });

  testWidgets('Selecting a row should update the selected list',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    tester.runAsync(() async {
      // Initial state: No rows selected
      expect(find.text('Selected: 0'), findsOneWidget);

      // Tap on the first row
      await tester.tap(find.text('John Doe'));
      await tester.pump();

      // After tapping, the selected list should have one item
      expect(find.text('Selected: 1'), findsOneWidget);
    });
  });
}

// You can also write additional unit tests for other functions or classes in your codebase.
