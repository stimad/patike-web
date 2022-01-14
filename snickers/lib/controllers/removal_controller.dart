import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snickers/data/rest/requests.dart';
import 'package:snickers/dtos/response.dart';
import 'package:snickers/dtos/search_snickers.dart';
import 'package:snickers/dtos/snickers.dart';

class RemovalController extends GetxController {
  static RemovalController instance = Get.find();

  final foundSnickers = [].obs;
  final isLoading = false.obs;
  final selectedIndex = 0.obs;
  final selectedRemoval = [true, false].obs;
  final description = "Brisanjem reda potpuno se brisu patike iz baze.".obs;
  final TextEditingController searchModelCtrl = TextEditingController();
  final TextEditingController searchSizeCtrl = TextEditingController();
  final TextEditingController searchColorCtrl = TextEditingController();

  String getDescritpion() {
    return description.value;
  }

  setisLoading(bool loading) {
    isLoading.value = loading;
    update();
  }

  List<Snickers> getFoundSnickers() {
    return [...foundSnickers];
  }

  resetFoundSnickers() {
    foundSnickers.value = [];
    update();
  }

  navigateToSection(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        selectedRemoval.value = [true, false];
        description.value = "Brisanjem reda potpuno se brisu patike iz baze.";
        break;
      case 1:
        selectedRemoval.value = [false, true];
        description.value =
            "Brisanjem reda ponistava se prodaja a kolicina patika se dodaje na ukupno stanje.";
        break;
      default:
        description.value = "Brisanjem reda potpuno se brisu patike iz baze.";
        selectedRemoval.value = [true, false];
    }
    update();
  }

  void findPropperSnickers(SearchSnickersDTO snickersFilter) {
    if (selectedIndex.value == 0) {
      findRemovalSnickers(snickersFilter);
    } else {
      findRemovalSoldSnickers(snickersFilter);
    }
  }

  setFoundSnickers(Map<dynamic, dynamic> res) {
    setisLoading(true);
    APIResponse response = APIResponse.fromJson(res);
    if (response.status == 0) {
      List results = response.results;
      foundSnickers.clear();
      for (Map res in results) {
        Snickers sn = Snickers(res['id'], res['model'], res['color'],
            res['size'], res['count'], 0);
        foundSnickers.add(sn);
      }
      setisLoading(false);
      update();
    }
  }

  SearchSnickersDTO getSearchFilter() {
    return SearchSnickersDTO(searchModelCtrl.text, searchColorCtrl.text,
        int.tryParse(searchSizeCtrl.text), null);
  }
}
