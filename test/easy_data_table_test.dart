import 'package:easy_data_table/easy_data_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'person.dart';

void main() {
  testWidgets(
      'EasyDataTable should render with the correct number of rows and columns',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EasyDataTable<Person>(
            columns: [
              EasyColumn(
                  headerText: 'Name', cellText: (item, index) => item.name),
              EasyColumn(
                  headerText: 'Age',
                  cellText: (item, index) => item.age.toString()),
            ],
            rows: const [
              Person(name: 'John Doe', age: 25),
              Person(name: 'Jane Doe', age: 30),
            ],
          ),
        ),
      ),
    );

    // Verify that the EasyDataTable widget renders correctly.
    expect(find.byType(EasyDataTable<Person>), findsOneWidget);

    // Verify that the DataTable widget renders correctly.
    expect(find.byType(DataTable), findsOneWidget);

    // Verify that the DataTable has two columns
    expect(find.text('Name'), findsOneWidget);

    tester.runAsync(() async {
      // Verify the number of rows and columns in the table
      expect(find.byType(DataRow), findsNWidgets(2)); // Assuming two rows
      expect(find.byType(DataCell),
          findsNWidgets(4)); // Assuming two columns in each row
    });
  });

  testWidgets('Selecting a row should trigger the onSelectChanged callback',
      (WidgetTester tester) async {
    List<Person> selectedPersons = [];

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EasyDataTable<Person>(
            columns: [
              EasyColumn(
                  headerText: 'Name', cellText: (item, index) => item.name),
              EasyColumn(
                  headerText: 'Age',
                  cellText: (item, index) => item.age.toString()),
            ],
            rows: const [
              Person(name: 'John Doe', age: 25),
              Person(name: 'Jane Doe', age: 30),
            ],
            onSelectChanged: (bool? selected, Person person) {
              if (selected != null && selected) {
                selectedPersons.add(person);
              }
            },
          ),
        ),
      ),
    );

    tester.runAsync(() async {
      // Tap on the first row to select it
      await tester.tap(find.text('John Doe'));
      await tester.pump();

      // Verify that the onSelectChanged callback was triggered
      expect(selectedPersons.length, 1);
      expect(selectedPersons[0].name, 'John Doe');
    });
  });
}
