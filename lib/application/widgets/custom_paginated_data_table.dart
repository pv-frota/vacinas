import 'package:flutter/material.dart';
import 'package:vacinas/domain/models/entity.dart';

class CustomPaginatedDataTable extends StatelessWidget {
  CustomPaginatedDataTable(
      {Key? key,
      required this.dataTableSource,
      required this.rowsPerPage,
      required this.header})
      : super(key: key);

  final int rowsPerPage;
  final String header;

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
    List<DataColumn> columns = [];
    for (String s in dataTableSource.dataSource[0].valuesDescriptions!) {
      columns.add(DataColumn(label: Text(s)));
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
    List<DataCell> cells = [];

    for (String s in entity.values!) {
      cells.add(DataCell(Text(s)));
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
