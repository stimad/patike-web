import 'package:flutter/material.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) {
  return AppBar(
    elevation: 0,
    leading: Row(children: [
      IconButton(
          onPressed: () {
            key.currentState!.openDrawer();
          },
          icon: const Icon(Icons.menu))
    ]),
    backgroundColor: Colors.blue,
    title: const Text("Stanje patika"),
  );
}
