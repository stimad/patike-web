import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewSnickersController extends GetxController {
  static NewSnickersController instance = Get.find();
  final newSnickersTolggle = [true, false].obs;
  final selectedIndex = 0.obs;

  final TextEditingController singleInsertModelCtrl = TextEditingController();
  final TextEditingController singleInsertSizeCtrl = TextEditingController();
  final TextEditingController singleInsertCountCtrl = TextEditingController();
  final TextEditingController singleInsertColorCtrl = TextEditingController();

  final TextEditingController seriesInsertModelCtrl = TextEditingController();
  final TextEditingController seriesInsertMinSizeCtrl = TextEditingController();
  final TextEditingController seriesInsertMaxSizeCtrl = TextEditingController();
  final TextEditingController seriesInsertCountCtrl = TextEditingController();
  final TextEditingController seriesInsertColorCtrl = TextEditingController();

  navigateToInsertSection(int index) {
    if (index == 0) {
      newSnickersTolggle.value = [true, false];
    } else {
      newSnickersTolggle.value = [false, true];
    }
    selectedIndex.value = index;
    update();
  }
}
