import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snickers/controllers/auth_controller.dart';
import 'package:snickers/controllers/menu_controller.dart';
import 'package:snickers/controllers/navigation_controller.dart';
import 'package:snickers/controllers/new_snickers_controller.dart';
import 'package:snickers/controllers/removal_controller.dart';
import 'package:snickers/controllers/selling_controller.dart';
import 'package:snickers/controllers/statistics_controller.dart';
import 'package:snickers/pages/authentication/user_authentication.dart';

void main() {
  Get.put(AuthController());
  Get.put(StatisticsController());
  Get.put(MenuController());
  Get.put(NavigationController());
  Get.put(NewSnickersController());
  Get.put(RemovalController());
  Get.put(SellingController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Patike',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserAuthentication(),
    );
  }
}
