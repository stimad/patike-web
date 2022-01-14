import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snickers/constants/controllers.dart';
import 'package:snickers/pages/input/widgets/single/single_insert.dart';

import 'series/series_insert.dart';

class SmallCardInsertion extends StatelessWidget {
  const SmallCardInsertion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => newSnickersController.selectedIndex.value == 0
        ? SeriesInsert()
        : SingleInsert());
  }
}
