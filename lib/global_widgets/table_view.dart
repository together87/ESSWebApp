import 'package:ecosys_safety/constants/app_colors.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '/common_libraries.dart';

class TableView extends StatefulWidget {
  final double? height;
  final List<String> columns;
  final List<List<Widget>> rows;
  final Function(int)? onRowClicked;

  const TableView(
      {super.key,
      this.height,
      this.columns = const [],
      this.rows = const [],
      this.onRowClicked});

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  late Map<String, double> columnWidths = {};
  DataGridController dataGridController = DataGridController();

  List<GridColumn> _buildColumns() => widget.columns
      .map(
        (column) => GridColumn(
          columnName: column,
          minimumWidth: column.contains('Assigned')
              ? 80.0
              : column.contains('Role')
                  ? 100
                  : 60.0,
          width: columnWidths[column] ?? double.nan,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Tooltip(
              message: column,
              preferBelow: false,
              child: Text(
                column,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  fontFamily: 'Poppins,sans-serif',
                ),
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      )
      .toList();

  @override
  void initState() {
    setState(() {
      for (final column in widget.columns) {
        columnWidths.addAll({column: double.nan});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: SfDataGridTheme(
        data: SfDataGridThemeData(
            brightness: Brightness.light,
            selectionColor: AppColors.terxtBgColor,
            headerColor: lightTeal,
            rowHoverColor: const Color(0xffe7f9fc)),
        child: SfDataGrid(
          controller: dataGridController,
          source: DataSource(
              columns: widget.columns,
              data: widget.rows,
              dataGridController: dataGridController),
          columnWidthMode: ColumnWidthMode.fill,
          columnResizeMode: ColumnResizeMode.onResize,
          onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
            setState(() {
              columnWidths[details.column.columnName] = details.width;
            });
            return true;
          },
          allowColumnsResizing: false,
          gridLinesVisibility: GridLinesVisibility.horizontal,
          headerGridLinesVisibility: GridLinesVisibility.none,
          headerRowHeight: 52,
          rowHeight: 48,
          selectionMode: SelectionMode.single,
          columns: _buildColumns(),
          onCellTap: (detail) {
            widget.onRowClicked!(detail.rowColumnIndex.rowIndex - 1);
          },
        ),
      ),
    );
  }
}

class DataSource extends DataGridSource {
  DataGridController? dataGridController;

  DataSource(
      {required List<List<Widget>> data,
      required List<String> columns,
      this.dataGridController}) {
    _entityData = List.generate(
      data.length,
      (index) => DataGridRow(
        cells: [
          for (int i = 0; i < columns.length; i++)
            DataGridCell(
              columnName: columns[i],
              value: data[index][i],
            )
        ],
      ),
    );
  }

  List<DataGridRow> _entityData = [];

  @override
  List<DataGridRow> get rows => _entityData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    Color getBackgroundColor() {
      int index = effectiveRows.indexOf(row);
      /*return dataGridController!.selectedRows.contains(row)
          ? AppColors.bgGreyColor
          : Colors.transparent;*/
      return Colors.transparent;

      /*if (index % 2 == 0) {
        return Colors.transparent;
      } else {
        return const Color(0xfff8f9fc);
      }*/
    }

    return DataGridRowAdapter(
        // color: getBackgroundColor(),
        cells: row.getCells().map<Widget>((e) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: e.value,
        ),
      );
    }).toList());
  }
}
