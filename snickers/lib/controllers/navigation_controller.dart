import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  static NavigationController instance = Get.find();
  final GlobalKey<NavigatorState> navigationKey = GlobalKey();

  Future<dynamic> navigateTo(String routeName) =>
      navigationKey.currentState!.pushNamed(routeName);

  goBack() => navigationKey.currentState!.pop();

  final isLoading = false.obs;

  setIsLoading(bool loading) {
    isLoading.value = loading;
  }
}
