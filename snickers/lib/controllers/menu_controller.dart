import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snickers/routing/routes.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = SnickersSale.obs;
  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;

  isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case SnickersInput:
        return _customIcon(Icons.edit, itemName);
      case SnickersStatus:
        return _customIcon(Icons.add_chart_outlined, itemName);
      case SnickersDeletion:
        return _customIcon(Icons.delete, itemName);
      case Authentication:
        return _customIcon(Icons.login, itemName);
      default:
        return _customIcon(Icons.wallet_membership, itemName);
    }
  }

  Widget _customIcon(IconData iconData, String itemName) {
    if (isActive(itemName)) {
      return Icon(
        iconData,
        size: 22,
        color: Colors.black,
      );
    }
    return Icon(
      iconData,
      color: isHovering(itemName) ? Colors.black : Colors.grey,
    );
  }
}
