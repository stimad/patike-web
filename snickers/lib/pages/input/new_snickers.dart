import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snickers/constants/controllers.dart';
import 'package:snickers/helpers/responsivness.dart';
import 'package:snickers/pages/input/widgets/large_card_insertion.dart';
import 'package:snickers/pages/input/widgets/small_card_insertion.dart';

class NewSnickers extends StatelessWidget {
  NewSnickers({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Obx(() => ToggleButtons(
                    children: const [
                      Icon(Icons.queue),
                      Icon(Icons.plus_one_rounded),
                    ],
                    onPressed: (int index) {
                      newSnickersController.navigateToInsertSection(index);
                    },
                    isSelected: newSnickersController.newSnickersTolggle.value,
                  )),
              const SizedBox(
                height: 5,
              ),
              ResponsiveWidget.isCustomScreen(context)
                  ? const LargeCardInsertion()
                  : const SmallCardInsertion(),
            ],
          )),
    );
  }
}
