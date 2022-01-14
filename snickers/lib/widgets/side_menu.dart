import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snickers/constants/colors.dart';
import 'package:snickers/constants/controllers.dart';
import 'package:snickers/pages/authentication/user_authentication.dart';
import 'package:snickers/routing/routes.dart';
import 'package:snickers/widgets/side_menu_item.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      color: light,
      child: ListView(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SizedBox(
                    width: _width / 48,
                  ),
                  const Padding(padding: EdgeInsets.only(right: 12)),
                  Flexible(
                      child: Text(
                    "Prodaja patika",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, color: dark),
                  )),
                  SizedBox(
                    width: _width / 48,
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Divider(
                color: lightGrey,
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItems
                .map((itemName) => SideMenuItem(
                    itemName: itemName,
                    onTap: () {
                      if (itemName == Authentication) {
                        Get.offAll(() => UserAuthentication());
                        authController.resetCredentials();
                      }

                      if (!menuController.isActive(itemName)) {
                        menuController.changeActiveItemTo(itemName);
                        // if(ResponsiveWidget.isSmallScreen(context)) {
                        //   Get.back();
                        // }
                        navigationController.navigateTo(itemName);
                      }
                    }))
                .toList(),
          )
        ],
      ),
    );
  }
}
