part of easy_data_table;

class EasyTablePagination extends StatelessWidget {
  EasyTablePagination({
    super.key,
    this.rowsPerPageOptions = const [5, 10, 25, 50],
    this.rowsPerPage = 25,
    this.page = 1,
    required this.count,
    required this.onPageChange,
    required this.onRowsPerPageChange,
  })  : assert((count ~/ rowsPerPage) + 1 > page, "Page is bigger than it can be"),
        assert(rowsPerPageOptions.contains(rowsPerPage), "rowsPerPageOptions must contain rowsPerPage");

  final int count;
  final int rowsPerPage;
  final List<int> rowsPerPageOptions;
  final int page;
  final Function(int page) onPageChange;
  final Function(int value) onRowsPerPageChange;

  @override
  Widget build(BuildContext context) {
    final startIndex = (page - 1) * rowsPerPage;
    final endIndex = startIndex + rowsPerPage;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Rows per page: '),
          const SizedBox(width: 10.0),
          DropdownButton<int>(
            value: rowsPerPage,
            items: rowsPerPageOptions
                .map(
                  (option) => DropdownMenuItem<int>(
                    value: option,
                    child: Text(option.toString()),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                onPageChange(1);
                onRowsPerPageChange(value);
              }
            },
          ),
          const SizedBox(width: 30.0),
          Text('${startIndex + 1}-$endIndex of $count'),
          const SizedBox(width: 20.0),
          IconButton(
            onPressed: () => onPageChange(max(page - 1, 1)),
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 18,
          ),
          IconButton(
            onPressed: () => onPageChange(min(page + 1, count ~/ rowsPerPage)),
            icon: const Icon(Icons.arrow_forward_ios),
            iconSize: 18,
          ),
        ],
      ),
    );
  }
}
