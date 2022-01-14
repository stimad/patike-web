import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:snickers/data/rest/requests.dart';
import 'package:snickers/dtos/response.dart';
import 'package:snickers/dtos/search_snickers.dart';
import 'package:snickers/dtos/selling_snickers.dart';
import 'package:snickers/dtos/snickers.dart';
import 'package:snickers/pages/status/details/all.dart';
import 'package:snickers/pages/status/details/edit.dart';
import 'package:snickers/pages/status/details/search.dart';
import 'package:snickers/pages/status/details/sold.dart';
import 'package:snickers/pages/status/details/unsold.dart';

class StatisticsController extends GetxController {
  static StatisticsController instance = Get.find();

  final snickers = [].obs;
  final soldSnickers = [].obs;
  final unsoldSnickers = [].obs;
  final sellingSnikcers = [].obs;
  final foundSnickers = [].obs;
  final TextEditingController searchModelCtrl = TextEditingController();
  final TextEditingController searchSizeCtrl = TextEditingController();
  final TextEditingController searchColorCtrl = TextEditingController();
  final TextEditingController editModelCtrl = TextEditingController();
  final TextEditingController editColorCtrl = TextEditingController();
  final TextEditingController editSizeCtrl = TextEditingController();
  final TextEditingController editCountCtrl = TextEditingController();
  final editId = 0.obs;
  final searchOnlyAvailable = true.obs;
  final selectedStatistics = [true, false, false, false].obs;
  final selectedIndex = 0.obs;
  final isLoading = false.obs;

  _setIsLoading(bool loading) {
    isLoading.value = loading;
    update();
  }

  setSearchOnlyAvailable(bool value) {
    searchOnlyAvailable.value = value;
    update();
  }

  SearchSnickersDTO getSearchFilter() {
    return SearchSnickersDTO(searchModelCtrl.text, searchColorCtrl.text,
        int.tryParse(searchSizeCtrl.text), searchOnlyAvailable.value);
  }

  setFoundSnickers(Map<dynamic, dynamic> res) {
    isLoading.value = true;
    APIResponse response = APIResponse.fromJson(res);
    if (response.status == 0) {
      List results = response.results;
      foundSnickers.clear();
      for (Map res in results) {
        Snickers sn = Snickers(res['id'], res['model'], res['color'],
            res['size'], res['count'], 0);
        foundSnickers.add(sn);
      }
      isLoading.value = false;
      update();
    }
  }

  List<Snickers> getFoundSnickers() {
    return [...foundSnickers];
  }

  setSnickers(Map<dynamic, dynamic> res) {
    isLoading.value = true;
    APIResponse response = APIResponse.fromJson(res);
    if (response.status == 0) {
      List results = response.results;
      snickers.clear();
      for (Map res in results) {
        Snickers sn = Snickers(res['id'], res['model'], res['color'],
            res['size'], res['count'], 0);
        snickers.add(sn);
      }
      isLoading.value = false;
      update();
    }
    // snickers.value = _snickers;
  }

  List<Snickers> getSnickers() {
    return [...snickers];
  }

  setSoldSnickers(Map<dynamic, dynamic> res) {
    isLoading.value = true;
    APIResponse response = APIResponse.fromJson(res);
    if (response.status == 0) {
      List results = response.results;
      soldSnickers.clear();
      for (Map res in results) {
        Snickers sn = Snickers(res['id'], res['model'], res['color'],
            res['size'], res['count'], 0);
        soldSnickers.add(sn);
      }
      isLoading.value = false;
      update();
    }
  }

  List<Snickers> getSoldSnickers() {
    return [...soldSnickers];
  }

  setUnsoldSnickers(Map<dynamic, dynamic> res) {
    isLoading.value = true;
    APIResponse response = APIResponse.fromJson(res);
    if (response.status == 0) {
      List results = response.results;
      unsoldSnickers.clear();
      for (Map res in results) {
        Snickers sn = Snickers(res['id'], res['model'], res['color'],
            res['size'], res['count'], 0);
        unsoldSnickers.add(sn);
      }
      isLoading.value = false;
      update();
    }
  }

  List<Snickers> getUnsoldSnickers() => [...unsoldSnickers];

  setSellingSnickers(Map<dynamic, dynamic> res) {
    isLoading.value = true;
    APIResponse response = APIResponse.fromJson(res);
    if (response.status == 0) {
      List results = response.results;
      sellingSnikcers.clear();
      for (Map res in results) {
        SellingSnickers sn = SellingSnickers(res['id'], res['model'],
            res['color'], res['size'], res['count'], 0, 1, 1);
        sellingSnikcers.add(sn);
      }
      isLoading.value = false;
      update();
    }
  }

  List<SellingSnickers> getSellingSnickers() => [...sellingSnikcers];

  navigateToSection(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        selectedStatistics.value = [true, false, false, false];
        break;
      case 1:
        selectedStatistics.value = [false, true, false, false];
        break;
      case 2:
        selectedStatistics.value = [false, false, true, false];
        break;
      case 3:
        selectedStatistics.value = [false, false, false, true];
        break;
      case 4:
        break;
      default:
        selectedStatistics.value = [true, false, false, false];
    }
    update();
  }

  Widget getPropperStatistics() {
    switch (selectedIndex.value) {
      case 0:
        return const SearchSnickers();
      case 1:
        return AllSnickers();
      case 2:
        return SoldSnickers();
      case 3:
        return UnsoldSnickers();
      case 4:
        return EditStatus();
      default:
        return AllSnickers();
    }
  }

  showEditWindow(int snickersId) {
    selectedIndex.value = 4;
    fetchSpecificSnickers(snickersId);
    update();
  }

  cancelEditing() {
    selectedIndex.value = 3;
    update();
  }

  populateEditForm(Map<dynamic, dynamic> res) {
    _setIsLoading(true);
    APIResponse response = APIResponse.fromJson(res);
    if (response.status == 0) {
      List results = response.results;
      Map res = results[0];
      editModelCtrl.text = res['model'];
      editColorCtrl.text = res['color'];
      editSizeCtrl.text = res['size'].toString();
      editCountCtrl.text = res['count'].toString();
      editId.value = res['id'];
      _setIsLoading(false);
      update();
    }
  }

  Snickers getEditSnickers() => Snickers(
      editId.value,
      editModelCtrl.text,
      editColorCtrl.text,
      int.tryParse(editSizeCtrl.text),
      int.tryParse(editCountCtrl.text),
      0);
}
