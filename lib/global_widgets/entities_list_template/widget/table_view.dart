import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../custom_data_cell.dart';
import '/data/model/entity.dart';

class DataTableView<T extends Entity> extends StatefulWidget {
  final List<T> entities;
  final List<String> columns;
  final ValueChanged<T> onRowClick;
  final ValueChanged<T>? onEditClick;
  final ValueChanged<T>? onDeleteClick;
  final String emptyMessage;
  final Map<String, double> columnWidths;
  final ValueChanged<MapEntry<String, double>> onColumnSizedUpated;
  final Color? borderColor;
  const DataTableView({
    super.key,
    this.entities = const [],
    this.columns = const [],
    required this.columnWidths,
    required this.onRowClick,
    this.onEditClick,
    this.onDeleteClick,
    this.emptyMessage = '',
    this.borderColor,
    required this.onColumnSizedUpated,
  });

  @override
  State<DataTableView> createState() => _DataTableViewState();
}

class _DataTableViewState extends State<DataTableView> {
  int? selectedColumnIndex;
  bool sortType = true;

  List<GridColumn> _buildColumns() => widget.columns.map(
        (column) {
          return GridColumn(
            columnName: column,
            width: widget.columnWidths[column]!,
            minimumWidth: 60.0,
            label: Container(
              alignment: column == "Action" ? Alignment.center : Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Tooltip(
                message: column,
                child: Text(
                  column,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, fontFamily: "Montserrat"),
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        },
      ).toList();

  @override
  Widget build(BuildContext context) {
    return widget.entities.isNotEmpty
        ? SfDataGridTheme(
            data: SfDataGridThemeData(
                // rowHoverColor: const Color(0xffe7f9fc),
                gridLineStrokeWidth: 0.5,
                gridLineColor: widget.borderColor),
            child: SfDataGrid(
              source: EntityDataSource(
                entityData: widget.entities,
                columns: widget.columns,
                onRowClick: widget.onRowClick,
                onEditClick: widget.onEditClick,
                onDeleteClick: widget.onDeleteClick,
              ),
              onCellTap: (details) {
                int rowIndex = details.rowColumnIndex.rowIndex;
                if (rowIndex > 0) {
                  widget.onRowClick(widget.entities[rowIndex - 1]);
                }
              },
              columnWidthMode: ColumnWidthMode.fill,
              columnResizeMode: ColumnResizeMode.onResize,
              onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                widget.onColumnSizedUpated(MapEntry(details.column.columnName, details.width));
                return true;
              },
              allowColumnsResizing: false,
              gridLinesVisibility: GridLinesVisibility.both,
              headerGridLinesVisibility: GridLinesVisibility.both,
              headerRowHeight: 50,
              rowHeight: 38,
              columns: _buildColumns(),
            ),
          )
        : Container(
            margin: const EdgeInsets.only(
              top: 200,
            ),
            child: Center(
              child: Text(
                widget.emptyMessage,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          );
  }
}

class EntityDataSource extends DataGridSource {
  final ValueChanged<Entity> onRowClick;
  final ValueChanged<Entity>? onEditClick;
  final ValueChanged<Entity>? onDeleteClick;
  EntityDataSource({
    required List<Entity> entityData,
    required List<String> columns,
    required this.onRowClick,
    this.onEditClick,
    this.onDeleteClick,
  }) {
    _entityData = List.generate(
      entityData.length,
      (index) => DataGridRow(
        cells: [
          ...(columns.isEmpty
              ? entityData[index]
                  .tableItemsToMap()
                  .entries
                  .map(
                    (value) => DataGridCell(
                      columnName: value.key,
                      value: {
                        'value': CustomDataCell(
                          data: value.value,
                          onRowClick: () => onRowClick(entityData[index]),
                        ),
                        'deleted': entityData[index].deleted,
                      },
                    ),
                  )
                  .toList()
              : columns.map(
                  (column) {
                    return DataGridCell(
                      columnName: column,
                      value: {
                        'value': CustomDataCell(
                          data: column == 'Number' ? (index + 1).toString() : entityData[index].tableItemsToMap()[column] ?? "",
                          onRowClick: () => onRowClick(entityData[index]),
                          onEditClick: () => onEditClick!(entityData[index]),
                          onDeleteClick: () => onDeleteClick!(entityData[index]),
                        ),
                        'deleted': entityData[index].deleted,
                      },
                    );
                  },
                ).toList()),
        ],
      ),
    );
  }

  List<DataGridRow> _entityData = [];

  @override
  List<DataGridRow> get rows => _entityData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return MouseRegion(
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: e.value['value'],
        ),
      );
    }).toList());
  }
}
