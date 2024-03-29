import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snickers/constants/controllers.dart';
import 'package:snickers/data/rest/requests.dart';

class StatusSnickers extends StatelessWidget {
  StatusSnickers({Key? key}) : super(key: key) {
    fetchAllSnickers();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(children: [
          const SizedBox(
            height: 5,
          ),
          Obx(() => ToggleButtons(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.search),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("SVE"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("PRODATE"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("NEPRODATE"),
                  ),
                ],
                onPressed: (int index) {
                  if (index != 0) {
                    navigationController.setIsLoading(true);
                  }
                  statisticsController.navigateToSection(index);
                },
                isSelected: statisticsController.selectedStatistics.value,
              )),
          const SizedBox(
            height: 5,
          ),
        ]),
        Obx(() => statisticsController.getPropperStatistics())
      ],
    );
  }
}
