library easy_data_table;

import 'dart:async';

import 'package:flutter/material.dart';

import 'src/utils.dart';
import 'src/widgets/empty.dart';

part 'src/easy_column.dart';

class EasyDataTable<T> extends StatefulWidget {
  final List<EasyColumn<T>> columns;
  final List<T> rows;
  final TextAlign textAlign;
  final Color? headerIconColor;
  final bool showCheckboxColumn;
  final MaterialStateProperty<Color?>? headingRowColor;
  final TextStyle? headingTextStyle;
  final EdgeInsets horizontalPadding;
  final MaterialStateProperty<Color?>? dataRowColor;
  final void Function(bool?, T item)? onSelectChanged;
  final List<T> selectedRows;
  final Color? selectedRowColor;
  final Widget Function(BuildContext context)? emptyItemBuilder;

  const EasyDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.textAlign = TextAlign.center,
    this.headerIconColor,
    this.showCheckboxColumn = true,
    this.headingRowColor,
    this.headingTextStyle,
    this.horizontalPadding = EdgeInsets.zero,
    this.dataRowColor,
    this.onSelectChanged,
    this.selectedRows = const [],
    this.selectedRowColor,
    this.emptyItemBuilder,
  });

  @override
  State<EasyDataTable<T>> createState() => _EasyDataTableState<T>();
}

class _EasyDataTableState<T> extends State<EasyDataTable<T>> {
  int? _currentSortColumn;
  bool _isAscending = true;

  @override
  Widget build(BuildContext context) {
    final List<T> rows = [...widget.rows];

    if (_currentSortColumn != null) {
      rows.sort((a, b) {
        return widget.columns[_currentSortColumn!].sort
                ?.call(a, b, _isAscending) ??
            0;
      });
    }

    final headingTextStyle = widget.headingTextStyle ??
        TextStyle(
          color: calculateTextColor(
              widget.headingRowColor?.resolve({MaterialState.pressed}) ??
                  Theme.of(context).primaryColor),
        );

    final dataTable = Theme(
      data: Theme.of(context).copyWith(
        iconTheme: Theme.of(context)
            .iconTheme
            .copyWith(color: widget.headerIconColor ?? headingTextStyle.color),
      ),
      child: DataTable(
        showCheckboxColumn: widget.showCheckboxColumn,
        headingRowColor: widget.headingRowColor ??
            MaterialStatePropertyAll(Theme.of(context).primaryColor),
        headingTextStyle: headingTextStyle,
        dataRowColor: widget.dataRowColor ??
            const MaterialStatePropertyAll(Color.fromRGBO(241, 240, 240, 1)),
        sortColumnIndex: _currentSortColumn,
        sortAscending: _isAscending,
        columns: widget.columns
            .map(
              (column) => DataColumn(
                mouseCursor: column.mouseCursor,
                tooltip: column.tooltip,
                label: column.headerBuilder ??
                    Expanded(
                      child: Text(
                        column.headerText,
                        textAlign: column.textAlign ?? widget.textAlign,
                      ),
                    ),
                onSort: column.sortable
                    ? (columnIndex, ascending) {
                        setState(() {
                          _currentSortColumn = columnIndex;
                          _isAscending = ascending;
                        });
                      }
                    : null,
              ),
            )
            .toList(),
        rows: rows.asMap().entries.map((entry) {
          final index = entry.key;
          final row = entry.value;
          final rowColor = widget.selectedRows.contains(row)
              ? (widget.selectedRowColor ??
                  const Color.fromARGB(255, 65, 158, 224).withOpacity(0.3))
              : null;
          return DataRow(
            selected: widget.showCheckboxColumn
                ? widget.selectedRows.contains(row)
                : false,
            color: MaterialStatePropertyAll(rowColor),
            onSelectChanged: widget.showCheckboxColumn
                ? (value) => widget.onSelectChanged?.call(value, row)
                : null,
            cells: widget.columns.map<DataCell>((column) {
              return DataCell(
                SizedBox(
                  width: column.width,
                  child: FutureBuilder<String?>(
                    future: Future.value(column.cellText(row, index)),
                    initialData: '',
                    builder: (context, snapshot) {
                      if (column.cellWidgetBuilder != null) {
                        return FutureBuilder<Widget?>(
                          future: Future.value(
                              column.cellWidgetBuilder?.call(row, index)),
                          initialData: const SizedBox(),
                          builder: (context, snapshot) =>
                              snapshot.data ?? const SizedBox(),
                        );
                      }
                      if ((column.textAlign ?? widget.textAlign) !=
                          TextAlign.center) {
                        return Text(
                          snapshot.data ?? '',
                          textAlign: column.textAlign ?? widget.textAlign,
                        );
                      }
                      return Center(
                        child: Text(
                          snapshot.data ?? '',
                          textAlign: column.textAlign ?? widget.textAlign,
                          maxLines: 1,
                        ),
                      );
                    },
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
            padding: widget.horizontalPadding,
            scrollDirection: Axis.horizontal,
            child: SizedBox(child: dataTable),
          ),
          if (rows.isEmpty)
            widget.emptyItemBuilder?.call(context) ??
                const EasyDataTableEmptyWidget(),
        ],
      ),
    );
  }
}
