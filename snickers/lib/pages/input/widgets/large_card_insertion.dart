import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snickers/constants/controllers.dart';
import 'package:snickers/pages/input/widgets/series/series_insert.dart';
import 'package:snickers/pages/input/widgets/single/single_insert.dart';

class LargeCardInsertion extends StatelessWidget {
  const LargeCardInsertion({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => newSnickersController.selectedIndex.value == 0 ? SeriesInsert() : SingleInsert());
  }
}