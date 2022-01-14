import 'package:flutter/material.dart';
import 'package:snickers/constants/controllers.dart';
import 'package:snickers/data/rest/client.dart';
import 'package:snickers/dtos/search_snickers.dart';
import 'package:snickers/dtos/selling_snickers.dart';
import 'package:snickers/dtos/snickers.dart';
import 'package:snickers/utils/utils.dart';

// ######### STATISTICS
void fetchAllSnickers() {
  executeGET("statistics/snickers/all")
      .then((value) => {statisticsController.setSnickers(value)});
}

void fetchUnsoldSnickers() {
  executeGET("statistics/unsold/snickers")
      .then((value) => {statisticsController.setUnsoldSnickers(value)});
}

void fetchSoldSnickers() {
  executeGET("statistics/sold/snickers")
      .then((value) => {statisticsController.setSoldSnickers(value)});
}

void findSnickers(SearchSnickersDTO snickersFilter) {
  executePOST("statistics/find", body: snickersFilter.toJson())
      .then((value) => statisticsController.setFoundSnickers(value));
}

void findRemovalSnickers(SearchSnickersDTO snickersFilter) {
  executePOST("statistics/find", body: snickersFilter.toJson())
      .then((value) => removalController.setFoundSnickers(value));
}

void findRemovalSoldSnickers(SearchSnickersDTO snickersFilter) {
  executePOST("statistics/sold/snickers/find", body: snickersFilter.toJson())
      .then((value) => removalController.setFoundSnickers(value));
}

void cancelSell(BuildContext context, int sellingSnikckersId) {
  executePOST("statistics/cancel/sell", body: {"id": sellingSnikckersId})
      .then((value) {
    checkCallbackRemoval(context, value, removalController.resetFoundSnickers);
  });
}

void findSnickersToSell(SearchSnickersDTO snickersFilter) {
  executePOST("statistics/find", body: snickersFilter.toJson())
      .then((value) => sellingController.setFoundSnickers(value));
}

void fetchSpecificSnickers(int snickersId) {
  executeGETQueryParam("statistics/snickers", {"id": snickersId.toString()})
      .then((value) => statisticsController.populateEditForm(value));
}

// ######### INSERTION

void insertSnickers(BuildContext context, Snickers snickers) {
  executePOST("add/snickers", body: snickers.toJson())
      .then((value) => checkInsertion(context, value));
}

void insertSnickersSeries(BuildContext context, List<Snickers> snickersSeries) {
  List<Map> jsonSnickersList = [];
  for (Snickers sn in snickersSeries) {
    jsonSnickersList.add(sn.toJson());
  }
  executePOST("add/snickers/series", body: {"snickersList": jsonSnickersList})
      .then((value) => checkInsertion(context, value));
}

// ######### REMOVAL

void removeSnickers(BuildContext context, Snickers snickers) {
  executeDELETE("delete/snickers", body: {"id": snickers.id}).then((value) {
    checkCallbackRemoval(context, value, removalController.resetFoundSnickers);
  });
}

// ######### SELLING

void sellSnickers(BuildContext context, Map snickersMap) {
  executePOST("selling/snickers", body: snickersMap)
      .then((value) => checkSell(context, value));
}

// ######### EDITING

void editSnickersState(
    BuildContext context, Snickers snickers, Function action) {
  executePUT("statistics/edit", body: snickers)
      .then((value) => checkEditing(context, value, action));
}

// ######### AUTHENTICATION

void authenticateUser(
    BuildContext context, String username, String password, Function action) {
  executePOST("auth/user", body: {"username": username, "password": password})
      .then((value) => checkAuthenitcation(context, value, action));
}
