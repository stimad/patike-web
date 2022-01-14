import 'package:flutter/material.dart';
import 'package:snickers/pages/authentication/user_authentication.dart';
import 'package:snickers/pages/input/new_snickers.dart';
import 'package:snickers/pages/removal/snickers_removal.dart';
import 'package:snickers/pages/sale/snickers_sale.dart';
import 'package:snickers/pages/status/snickers_status.dart';
import 'package:snickers/routing/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SnickersInput:
      return _getPageRoute(NewSnickers());
    case SnickersStatus:
      return _getPageRoute(StatusSnickers());
    case SnickersDeletion:
      return _getPageRoute(const SnickersRemoval());
    case Authentication:
      return _getPageRoute(UserAuthentication());
    default:
      return _getPageRoute(const SaleSnickers());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
