# Easy Data Table

[![pub package](https://img.shields.io/pub/v/easy_data_table?label=pub.dev&labelColor=333940&logo=dart)](https://pub.dev/packages/easy_data_table)


`easy_data_table` is a simple and efficient way to use data tables in Flutter.

<img src="https://raw.githubusercontent.com/oseeshogun/easy_data_table/main/example/example.png" alt="Image Demo" height="400"/>

## Features

- **Simplified Data Tables**, Easily create data tables with minimal code.
- **Selection**, Enable row selection with a checkbox column.
- **Customization** Customize appearance with various options.
- **Pagination** Implement pagination for large datasets
- **Sorting** by predefined columns

## Get Started

To use this package, follow these steps:

### 1. Depend on it

Add this to your package's `pubspec.yaml` file:

```bash
flutter pub add easy_data_table
```

### 2. Import it

Add this import to your Dart code:

```dart
import 'package:easy_data_table/easy_data_table.dart';
```


## Usage

Using `easy_data_table` is straightforward. Create a DataTable widget with your data:

```dart
EasyDataTable<YourDataModel>(
  columns: [
    EasyColumn(headerText: 'ID', ...),
    EasyColumn(headerText: 'Name', ...),
    EasyColumn(headerText: 'Age', ...),
  ],
  rows: [
    // Populate your data
    // Example: YourDataModel(id: 1, name: 'John Doe', age: 25),
    // Example: YourDataModel(id: 2, name: 'Jane Doe', age: 30),
  ],
)
```

## FAQ

### Q: How do I customize the appearance of cells?
A: You can use the `EasyColumn` options such as `cellWidgetBuilder`, `textAlign`, and `width` to customize cell appearance.

## Support and Contact

- Email: [omasuaku@gmail.com](mailto:omasuaku@gmail.com)
- Github: [oseeshogun](https://github.com/oseeshogun)

## Contribute

Any suggestion to improve/add is welcome, if you want to make a PR, you are welcome :)