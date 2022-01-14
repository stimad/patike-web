
import 'package:flutter/widgets.dart';
import 'package:snickers/constants/controllers.dart';
import 'package:snickers/routing/router.dart';
import 'package:snickers/routing/routes.dart';

Navigator localNavigator() => Navigator(
  key: navigationController.navigationKey,
  initialRoute: SnickersSale,
  onGenerateRoute: generateRoute,
);