import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snickers/controllers/statistics_controller.dart';
import 'package:snickers/dtos/selling_snickers.dart';

class Selling extends StatelessWidget {
  const Selling({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const Text("Snickers selling"),
          Obx(() => DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 600,
              columns: const [
                DataColumn2(
                  label: Text('Model'),
                  size: ColumnSize.L,
                ),
                DataColumn(
                  label: Text('Boja'),
                ),
                DataColumn(
                  label: Text('Veličina'),
                ),
                DataColumn(
                  label: Text('Komada'),
                ),
                DataColumn(
                  label: Text('ID'),
                  numeric: true,
                ),
              ],
              rows: _createDataRows(
                  StatisticsController.instance.getSellingSnickers()))),
        ],
      ),
    );
  }

  List<DataRow> _createDataRows(List<SellingSnickers> sellingSnickersList) {
    List<DataRow> rows = [];
    for (SellingSnickers sellingSnickers in sellingSnickersList) {
      rows.add(DataRow(cells: [
        DataCell(Text(sellingSnickers.model!)),
        DataCell(Text(sellingSnickers.color!)),
        DataCell(Text(sellingSnickers.size.toString())),
        DataCell(Text(sellingSnickers.count.toString())),
        DataCell(Text(sellingSnickers.id.toString())),
      ]));
    }
    return rows;
  }
}
