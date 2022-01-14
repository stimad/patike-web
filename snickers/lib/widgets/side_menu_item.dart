import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snickers/constants/colors.dart';
import 'package:snickers/constants/controllers.dart';
import 'package:snickers/routing/routes.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final Function onTap;

  const SideMenuItem({Key? key, required this.itemName, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => onTap(),
      onHover: (value) {
        value
            ? menuController.onHover(itemName)
            : menuController.onHover("nothing hovered");
      },
      child: Obx(() => Container(
            color: menuController.isHovering(itemName)
                ? Colors.grey.withOpacity(.1)
                : Colors.transparent,
            child: Row(
              children: [
                Visibility(
                  visible: menuController.isHovering(itemName) ||
                      menuController.isActive(itemName),
                  child: Container(
                    width: 6,
                    height: 40,
                    color: Colors.black,
                  ),
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                ),
                SizedBox(
                  width: _width / 80,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: menuController.returnIconFor(itemName),
                ),
                if (!menuController.isActive(itemName))
                  Flexible(
                      child: Text(
                    translateItemName(itemName),
                    style: TextStyle(
                        color: menuController.isHovering(itemName)
                            ? Colors.black
                            : darkBlue,
                        fontWeight: FontWeight.bold),
                  ))
                else
                  Flexible(
                      child: Text(
                    translateItemName(itemName),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ))
              ],
            ),
          )),
    );
  }

  translateItemName(String itemName) {
    switch (itemName) {
      case SnickersStatus:
        return "Status patika";
      case SnickersInput:
        return "Unos novih patika";
      case SnickersDeletion:
        return "Uklanjanje patika";
      case Authentication:
        return "Odjavi se";
      default:
        return "Prodaja patika";
    }
  }
}
