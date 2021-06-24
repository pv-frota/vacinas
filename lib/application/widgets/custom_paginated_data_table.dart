import 'package:flutter/material.dart';
import 'package:vacinas/application/pages/utils/responsive.dart';
import 'package:vacinas/domain/models/entity.dart';

class CustomPaginatedDataTable extends StatefulWidget {
  const CustomPaginatedDataTable(
      {Key? key,
      required this.data,
      required this.rowsPerPage,
      required this.header,
      this.onTap})
      : super(key: key);

  final int rowsPerPage;
  final String header;
  final void Function(int index)? onTap;

  final List<Entity> data;
  @override
  _CustomPaginatedDataTableState createState() =>
      _CustomPaginatedDataTableState();
}

class _CustomPaginatedDataTableState extends State<CustomPaginatedDataTable> {
  late int rowsPerPage;
  late String header;
  late List<Entity> data;

  void Function(int index)? onTap;
  int? _selectedIndex;

  @override
  void initState() {
    this.data = widget.data;
    this.header = widget.header;
    this.onTap = widget.onTap;
    this.rowsPerPage = widget.rowsPerPage;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      child: PaginatedDataTable(
        source: DataTableSourceIplm(
            dataSource: data,
            isSelected: (index) => isSelected(index),
            selectRow: (index) => selectRow(index),
            onTap: onTap),
        header: Text(header),
        rowsPerPage: rowsPerPage,
        columns: generateDataColumns(),
        onSelectAll: (_) {
          setState(() {
            _selectedIndex = null;
          });
        },
      ),
    );
  }

  bool isSelected(int test) =>
      _selectedIndex != null ? test == _selectedIndex : false;

  void selectRow(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<DataColumn> generateDataColumns() {
    List<DataColumn> columns = [];
    for (String s in data[0].valuesDescriptions!) {
      columns.add(DataColumn(label: Text(s)));
    }
    return columns;
  }
}

///Class responsible with dealing with [PaginatedDataTable] needs
class DataTableSourceIplm extends DataTableSource {
  List<Entity> dataSource;
  void Function(int index)? onTap;

  int _selectedCount = 0;
  final void Function(int index) selectRow;
  final bool Function(int index) isSelected;

  DataTableSourceIplm(
      {required this.dataSource,
      required this.isSelected,
      required this.selectRow,
      this.onTap});

  List<DataCell> generateDataCells(Entity e) {
    List<DataCell> cells = [];

    for (String s in e.values!) {
      cells.add(DataCell(Text(s)));
    }
    return cells;
  }

  @override
  DataRow? getRow(int index) {
    final entity = dataSource[index];
    return DataRow.byIndex(
      index: index,
      selected: isSelected(index),
      cells: generateDataCells(entity),
      onSelectChanged: onTap == null
          ? null
          : (value) {
              selectRow(index);
              _selectedCount = 1;
              notifyListeners();
              onTap!(index);
            },
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataSource.length;

  @override
  int get selectedRowCount => _selectedCount;
}
