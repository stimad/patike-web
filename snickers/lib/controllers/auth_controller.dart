import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snickers/constants/controllers.dart';
import 'package:snickers/data/rest/requests.dart';
import 'package:snickers/routing/routes.dart';
import 'package:snickers/utils/utils.dart';
import 'package:snickers/widgets/layout.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  final TextEditingController authUsernameCtrl = TextEditingController();
  final TextEditingController authPasswordCtrl = TextEditingController();

  void authenticate(BuildContext context) {
    if (authPasswordCtrl.text.isEmpty || authUsernameCtrl.text.isEmpty) {
      showErrorDialog(
          context, "Greška", "Lozinka i korisničko ime ne mogu biti prazni.");
      return;
    }
    String password = _prepareAuthPassword();
    authenticateUser(context, authUsernameCtrl.text, password, () {
      Get.offAll(() => SiteLayout());
      menuController.changeActiveItemTo(SnickersSale);
    });
  }

  String _prepareAuthPassword() {
    var bytes = utf8.encode(authPasswordCtrl.text);
    var digest = sha1.convert(bytes);
    return digest.toString();
  }

  void resetCredentials() {
    authUsernameCtrl.clear();
    authPasswordCtrl.clear();
  }
}
