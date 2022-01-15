import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snickers/constants/controllers.dart';
import 'package:snickers/dtos/response.dart';
import 'package:snickers/dtos/snickers.dart';
import 'package:snickers/widgets/spinner.dart';

bool isNumeric(String? s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

List<DataRow> createDataRows(List<Snickers> snickersList) {
  List<DataRow> rows = [];
  for (Snickers snickers in snickersList) {
    rows.add(DataRow(cells: [
      DataCell(Text(snickers.model!)),
      DataCell(Text(snickers.color!)),
      DataCell(Text(snickers.size.toString())),
      DataCell(Text(snickers.count.toString())),
      DataCell(Text(snickers.id.toString())),
    ]));
  }
  return rows;
}

void showActionDialog(
    BuildContext context, String title, String content, Function action) {
  Get.defaultDialog(
      title: title,
      middleText: content,
      backgroundColor: Colors.green,
      titleStyle: const TextStyle(color: Colors.white),
      middleTextStyle: const TextStyle(color: Colors.white),
      cancelTextColor: Colors.red,
      confirmTextColor: Colors.white,
      textConfirm: "DA",
      textCancel: "NE",
      onConfirm: () {
        action();
        Get.back();
      },
      onCancel: () {
        Get.back();
      });
}

void showOKActionDialog(
    BuildContext context, String title, String content, Function action) {
  Get.defaultDialog(
    title: title,
    middleText: content,
    backgroundColor: Colors.green,
    titleStyle: const TextStyle(color: Colors.white),
    middleTextStyle: const TextStyle(color: Colors.white),
    cancelTextColor: Colors.red,
    confirmTextColor: Colors.white,
    textConfirm: "OK",
    onConfirm: () {
      action();
      Get.back();
    },
  );
}

void showOKDialog(BuildContext context, String title, String content) {
  Get.defaultDialog(
      title: title,
      middleText: content,
      backgroundColor: Colors.green,
      titleStyle: const TextStyle(color: Colors.white),
      middleTextStyle: const TextStyle(color: Colors.white),
      textConfirm: "OK",
      onConfirm: () {
        Get.back();
      });
}

void showErrorDialog(BuildContext context, String title, String content) {
  Get.defaultDialog(
      title: title,
      middleText: content,
      backgroundColor: Colors.red[200],
      titleStyle: const TextStyle(color: Colors.white),
      middleTextStyle: const TextStyle(color: Colors.white),
      textConfirm: "OK",
      onConfirm: () {
        Get.back();
      });
}

void checkInsertion(BuildContext context, Map<dynamic, dynamic> res) {
  APIResponse response = APIResponse.fromJson(res);
  if (response.status != 0) {
    showErrorDialog(context, "Greska", "Greska u komunikaciji!");
  } else {
    showOKDialog(context, "Uspesan unos", "Uspesan unos.");
  }
}

void checkEditing(
    BuildContext context, Map<dynamic, dynamic> res, Function action) {
  APIResponse response = APIResponse.fromJson(res);
  if (response.status != 0) {
    showErrorDialog(context, "Greska", "Greska u komunikaciji!");
  } else {
    showOKActionDialog(context, "Uspešno", "Uspešna promena stanja.", action);
  }
}

void checkAuthenitcation(
    BuildContext context, Map<dynamic, dynamic> res, Function action) {
  APIResponse response = APIResponse.fromJson(res);
  if (response.status != 0) {
    showErrorDialog(context, "Greska", "Greska u autentikaciji!");
  } else {
    action();
  }
}

void checkSell(BuildContext context, Map<dynamic, dynamic> res) {
  APIResponse response = APIResponse.fromJson(res);
  if (response.status != 0) {
    showErrorDialog(context, "Greska", "Greska u komunikaciji!");
  } else {
    showOKDialog(context, "Uspesno", "Uspesna prodaja.");
  }
}

void checkRemoval(BuildContext context, Map<dynamic, dynamic> res) {
  APIResponse response = APIResponse.fromJson(res);
  if (response.status != 0) {
    showErrorDialog(context, "Greska", "Greska u komunikaciji!");
  } else {
    showOKDialog(context, "Uspesno", "Uspesno obrisano.");
  }
}

void checkCallbackRemoval(
    BuildContext context, Map<dynamic, dynamic> res, Function callback) {
  APIResponse response = APIResponse.fromJson(res);
  if (response.status != 0) {
    showErrorDialog(context, "Greska", "Greska u komunikaciji!");
  } else {
    callback();
    showOKDialog(context, "Uspesno", "Uspesno obrisano.");
  }
}

bool areSnickersValuesOK(Snickers snickers) {
  if (snickers.color == null ||
      snickers.color!.isEmpty ||
      snickers.model == null ||
      snickers.model!.isEmpty ||
      snickers.size == null ||
      snickers.size! < 0 && snickers.count == null ||
      snickers.count! < 0) return false;
  return true;
}

Widget appendSpinner(Widget screen) {
  return Stack(children: [
    screen,
    Obx(() =>
        navigationController.isLoading.value ? const Spinner() : Container())
  ]);
}
