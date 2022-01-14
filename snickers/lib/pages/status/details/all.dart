import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snickers/constants/controllers.dart';
import 'package:snickers/data/rest/requests.dart';
import 'package:snickers/utils/utils.dart';
import 'package:snickers/widgets/spinner.dart';

class AllSnickers extends StatelessWidget {
  AllSnickers({Key? key}) : super(key: key) {
    fetchAllSnickers();
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }

  Widget _getContent() {
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
                      DataColumn(
                        label: Text('ID'),
                        numeric: true,
                      ),
                    ],
                    rows: createDataRows(statisticsController.getSnickers())),
              ),
            ),
    );
  }
}
