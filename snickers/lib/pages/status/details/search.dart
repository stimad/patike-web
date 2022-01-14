import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snickers/constants/controllers.dart';
import 'package:snickers/dtos/snickers.dart';
import 'package:snickers/pages/status/details/search_input.dart';
import 'package:snickers/widgets/spinner.dart';

class SearchSnickers extends StatelessWidget {
  const SearchSnickers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          // const SizedBox(height: 30, child: Text("Pretraga")),
          SearchInputSnickers(),
          _getContent(context)
        ],
      ),
    );
  }

  Widget _getContent(BuildContext context) {
    return Obx(
      () => statisticsController.isLoading.value
          ? const Spinner()
          : Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable2(
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
                      DataColumn(label: Text("Izmeni")),
                      DataColumn(
                        label: Text('ID'),
                        numeric: true,
                      ),
                    ],
                    rows: _createDataRows(
                        statisticsController.getFoundSnickers(), context)),
              ),
            ),
    );
  }

  List<DataRow> _createDataRows(
      List<Snickers> snickersList, BuildContext context) {
    List<DataRow> rows = [];
    for (Snickers snickers in snickersList) {
      rows.add(DataRow(cells: [
        DataCell(Text(snickers.model!)),
        DataCell(Text(snickers.color!)),
        DataCell(Text(snickers.size.toString())),
        DataCell(Text(snickers.count.toString())),
        DataCell(IconButton(
          onPressed: () {
            statisticsController.showEditWindow(snickers.id);
          },
          icon: const Icon(
            Icons.edit,
            color: Colors.green,
          ),
        )),
        DataCell(Text(snickers.id.toString())),
      ]));
    }
    return rows;
  }
}
