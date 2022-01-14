import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snickers/dtos/response.dart';
import 'package:snickers/dtos/search_snickers.dart';
import 'package:snickers/dtos/snickers.dart';

class SellingController extends GetxController {
  static SellingController instance = Get.find();

  final foundSnickers = [].obs;
  final isLoading = false.obs;
  final TextEditingController searchModelCtrl = TextEditingController();
  final TextEditingController searchSizeCtrl = TextEditingController();
  final TextEditingController searchColorCtrl = TextEditingController();
  final TextEditingController countCtrl = TextEditingController();

  setisLoading(bool loading) {
    isLoading.value = loading;
    update();
  }

  List<Snickers> getFoundSnickers() {
    return [...foundSnickers];
  }

  SearchSnickersDTO getSearchFilter() {
    return SearchSnickersDTO(searchModelCtrl.text, searchColorCtrl.text,
        int.tryParse(searchSizeCtrl.text), true);
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

  void restartFoundSnickers() {
    foundSnickers.value = [];
    update();
  }
}
