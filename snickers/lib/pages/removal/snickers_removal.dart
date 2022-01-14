import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snickers/constants/controllers.dart';
import 'package:snickers/data/rest/requests.dart';
import 'package:snickers/dtos/snickers.dart';
import 'package:snickers/pages/removal/widgets/search_input.dart';
import 'package:snickers/utils/utils.dart';
import 'package:snickers/widgets/spinner.dart';

class SnickersRemoval extends StatelessWidget {
  const SnickersRemoval({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Obx(() => ToggleButtons(
              children: const [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("NA STANJU"),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("PRODAVANE"),
                ),
              ],
              onPressed: (int index) {
                removalController.navigateToSection(index);
              },
              isSelected: removalController.selectedRemoval,
            )),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Obx(() => Text(removalController.getDescritpion())),
        ),
        SearchInputSnickers(),
        _getContent(context)
      ],
    );
  }

  Widget _getContent(BuildContext context) {
    return Obx(
      () => removalController.isLoading.value
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
                      DataColumn(label: Text("Brisanje")),
                      DataColumn(
                        label: Text('ID'),
                        numeric: true,
                      ),
                    ],
                    rows: _createRemovalDataRows(
                        removalController.getFoundSnickers(), context)),
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
            if (removalController.selectedIndex.value == 0) {
              showActionDialog(
                  context,
                  "Provera",
                  "Da li ste sigurni da zelite da potpuno uklonite patike: ${snickers.model} boje: ${snickers.color} velicine: ${snickers.size}",
                  () => removeSnickers(context, snickers));
            } else {
              showActionDialog(
                  context,
                  "Provera",
                  "Da li ste sigurni da zelite da ponistite prodaju patike: ${snickers.model} boje: ${snickers.color} velicine: ${snickers.size}",
                  () => cancelSell(context, snickers.id));
            }
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        )),
        DataCell(Text(snickers.id.toString())),
      ]));
    }
    return rows;
  }
}
