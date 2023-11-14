part of easy_data_table;

class EasyColumn<T> {
  /// The header text of the column
  final String headerText;

  /// The header widget of the column, if null, the headerText will be used
  ///
  /// Typically, this will be a [Text] widget. It could also be an
  /// [Icon] (typically using size 18), or a [Row] with an icon and
  /// some text.
  ///
  /// The [label] is placed within a [Row] along with the
  /// sort indicator (if applicable). By default, [label] only occupy minimal
  /// space. It is recommended to place the label content in an [Expanded] or
  /// [Flexible] as [label] to control how the content flexes. Otherwise,
  /// an exception will occur when the available space is insufficient.
  ///
  /// By default, [DefaultTextStyle.softWrap] of this subtree will be set to false.
  /// Use [DefaultTextStyle.merge] to override it if needed.
  ///
  /// The label should not include the sort indicator.
  final Widget? headerBuilder;

  /// The cell text for the column
  final FutureOr<String?> Function(T item, int index) cellText;

  /// The cell widget for the column, if null, the cellText will be used
  final FutureOr<Widget?> Function(T item, int index)? cellWidgetBuilder;

  /// Whether the column is sortable
  final bool sortable;

  /// The alignment of the text in the cell
  final TextAlign? textAlign;

  /// The width of the column, if null, the column will take up the remaining space
  final double? width;

  /// The column heading's tooltip.
  ///
  /// This is a longer description of the column heading, for cases
  /// where the heading might have been abbreviated to keep the column
  /// width to a reasonable size.
  final String? tooltip;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// heading row.
  ///
  /// [MaterialStateProperty.resolve] is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.disabled].
  ///
  /// If this is null, then the value of [DataTableThemeData.headingCellCursor]
  /// is used. If that's null, then [MaterialStateMouseCursor.clickable] is used.
  ///
  /// See also:
  ///  * [MaterialStateMouseCursor], which can be used to create a [MouseCursor].
  final MaterialStateProperty<MouseCursor?>? mouseCursor;

  const EasyColumn({
    required this.headerText,
    this.headerBuilder,
    required this.cellText,
    this.cellWidgetBuilder,
    this.sortable = false,
    this.textAlign,
    this.width,
    this.tooltip,
    this.mouseCursor,
    int Function(T a, T b, bool ascending)? sort,
  }) : _order = sort;

  final int Function(T a, T b, bool ascending)? _order;

  /// Sort Function
  int Function(T a, T b, bool ascending)? get sort => _order ?? EasyColumn._defaultSortFunction;

  static int _defaultSortFunction<T>(T a, T b, bool ascending) {
    if (ascending) {
      return a.toString().compareTo(b.toString());
    } else {
      return b.toString().compareTo(a.toString());
    }
  }
}
