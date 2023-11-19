import 'package:easy_data_table/easy_data_table.dart';
import 'package:example/person.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy DataTable Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Easy DataTable'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Person> selected = [];
  int rowsPerPage = 3;
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: EasyDataTable<Person>(
                    rowsPerPage: rowsPerPage,
                    currentPage: page,
                    selectedRows: selected,
                    onSelectChanged: (value, item) {
                      setState(() {
                        if (value == true) {
                          selected.add(item);
                        } else {
                          selected.remove(item);
                        }
                      });
                    },
                    columns: [
                      EasyColumn(
                        headerText: 'Name',
                        cellText: (person, i) => person.name,
                        sortable: true,
                      ),
                      EasyColumn(
                        headerText: 'Age',
                        cellText: (person, i) => person.age.toString(),
                        sortable: true,
                        sort: (a, b, ascending) {
                          if (ascending) {
                            return a.age.compareTo(b.age);
                          } else {
                            return b.age.compareTo(a.age);
                          }
                        },
                      ),
                      EasyColumn(
                        headerText: 'Married',
                        cellText: (person, i) => person.isMarried ? 'Yes' : 'No',
                      ),
                      EasyColumn(
                        headerText: 'Height',
                        cellText: (person, i) => person.height.toStringAsFixed(2),
                      ),
                      EasyColumn(headerText: 'City', cellText: (person, i) => person.city, textAlign: TextAlign.left),
                    ],
                    rows: persons,
                    paginatorBuilder: (context) {
                      return Container(
                        alignment: Alignment.centerRight,
                        child: EasyTablePagination(
                          count: persons.length,
                          rowsPerPage: rowsPerPage,
                          page: page,
                          onPageChange: (int value) => setState(() => (page = value)),
                          onRowsPerPageChange: (value) => setState(() => (rowsPerPage = value)),
                          rowsPerPageOptions: const [3, 10, 30],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
