import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snickers/constants/controllers.dart';
import 'package:snickers/data/rest/requests.dart';
import 'package:snickers/dtos/snickers.dart';
import 'package:snickers/pages/sale/widgets/search_input.dart';
import 'package:snickers/utils/utils.dart';

class SaleSnickers extends StatelessWidget {
  const SaleSnickers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "PRODAJA",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
        SearchInputSnickers(),
        _getContent(context)
      ],
    );
  }

  Widget _getContent(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Obx(
          () => DataTable2(
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
                DataColumn(label: Text("Prodaja")),
                DataColumn(
                  label: Text('ID'),
                  numeric: true,
                ),
              ],
              rows: _createRemovalDataRows(
                  sellingController.getFoundSnickers(), context)),
        ),
      ),
    );
  }

  List<DataRow> _createRemovalDataRows(
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
            showActionDialog(
                context,
                "Provera",
                "Da li ste sigurni da zelite da prodate patike: ${snickers.model} boje: ${snickers.color} velicine: ${snickers.size}",
                () => _sellSnickers(context, snickers));
          },
          icon: const Icon(
            Icons.attach_money,
            color: Colors.green,
          ),
        )),
        DataCell(Text(snickers.id.toString())),
      ]));
    }
    return rows;
  }

  void _sellSnickers(BuildContext context, Snickers snickers) {
    sellSnickers(context, {
      "snickers_id": snickers.id,
      "price": 0,
      "count": sellingController.countCtrl.text
    });
    sellingController.restartFoundSnickers();
  }
}
