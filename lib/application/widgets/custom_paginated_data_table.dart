import 'package:flutter/material.dart';
import 'package:vacinas/domain/models/entity.dart';

class CustomPaginatedDataTable extends StatelessWidget {
  CustomPaginatedDataTable(
      {Key? key,
      required this.dataTableSource,
      required this.rowsPerPage,
      required this.header,
      required this.keyColumnName,
      required this.nameColumnName,
      this.optional1ColumnName,
      this.optional2ColumnName,
      this.optional3ColumnName})
      : super(key: key);

  final int rowsPerPage;
  final String header;
  final String keyColumnName;
  final String nameColumnName;
  final String? optional1ColumnName;
  final String? optional2ColumnName;
  final String? optional3ColumnName;

  final DataTableSourceIplm dataTableSource;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: PaginatedDataTable(
          source: dataTableSource,
          header: Text(header),
          rowsPerPage: rowsPerPage,
          columns: generateDataColumns()),
    );
  }

  List<DataColumn> generateDataColumns() {
    List<DataColumn> columns = [
      DataColumn(label: Text(keyColumnName)),
      DataColumn(label: Text(nameColumnName))
    ];
    if (optional1ColumnName != null) {
      columns.add(DataColumn(label: Text(optional1ColumnName!)));
    }
    if (optional2ColumnName != null) {
      columns.add(DataColumn(label: Text(optional2ColumnName!)));
    }
    if (optional3ColumnName != null) {
      columns.add(DataColumn(label: Text(optional3ColumnName!)));
    }
    return columns;
  }
}

///Class responsible with dealing with [PaginatedDataTable] needs
class DataTableSourceIplm extends DataTableSource {
  List<Entity> dataSource;

  DataTableSourceIplm({required this.dataSource});

  List<DataCell> generateDataCells(int index) {
    Entity entity = dataSource[index];
    List<DataCell> cells = [
      DataCell(Text(entity.key.toString())),
      DataCell(Text(entity.name))
    ];

    if (entity.optional1 != null) {
      cells.add(DataCell(Text(entity.optional1!)));
    }

    if (entity.optional2 != null) {
      cells.add(DataCell(Text(entity.optional2!)));
    }

    if (entity.optional3 != null) {
      cells.add(DataCell(Text(entity.optional3!)));
    }
    return cells;
  }

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: generateDataCells(index));
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataSource.length;

  @override
  int get selectedRowCount => 0;
}
