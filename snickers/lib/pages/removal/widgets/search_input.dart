import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:snickers/constants/controllers.dart';
import 'package:snickers/utils/utils.dart';

class SearchInputSnickers extends StatelessWidget {
  SearchInputSnickers({Key? key}) : super(key: key);

  final FocusNode _modelFocusNode = FocusNode();
  final FocusNode _colorFocusNode = FocusNode();
  final FocusNode _sizeFocusNode = FocusNode();

  _nextFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  _submitForm() {
    navigationController.setIsLoading(true);
    removalController.findPropperSnickers(removalController.getSearchFilter());
  }

  String? _validateNumber(String? value) {
    String? _nonEmptyValidatorRes = _validateNonEmpty(value);
    if (_nonEmptyValidatorRes != null) {
      return _nonEmptyValidatorRes;
    }
    if (!isNumeric(value)) {
      return "Unos mora biti numerički!";
    }
    return null;
  }

  String? _validateNonEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return "Unos ne može biti prazan!";
    }
    return null;
  }

  void _selectFromdDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    removalController.fromDate.value = picked ?? DateTime.now();
  }

  void _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    removalController.toDate.value = picked ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final dFormat = DateFormat("yyyy-MM-dd");
    return Card(
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              focusNode: _modelFocusNode,
              onFieldSubmitted: (String value) {
                _nextFocus(context, _colorFocusNode);
              },
              controller: removalController.searchModelCtrl,
              // onChanged: (value) =>
              //     removalController.setSearchSnickersModel(value),
              validator: (String? value) => _validateNonEmpty(value),
              decoration: const InputDecoration(
                hintText: 'Unesi model patike',
                labelText: 'Model patike',
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              focusNode: _colorFocusNode,
              onFieldSubmitted: (String value) {
                _nextFocus(context, _sizeFocusNode);
              },
              controller: removalController.searchColorCtrl,
              decoration: const InputDecoration(
                hintText: 'Unesi boju patike',
                labelText: 'Boja patike',
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              focusNode: _sizeFocusNode,
              validator: (String? value) => _validateNumber(value),
              controller: removalController.searchSizeCtrl,
              decoration: const InputDecoration(
                hintText: 'Unesi velicinu patike',
                labelText: 'Velicina patike',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(() => removalController.selectedIndex.value != 0
                ? Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => _selectFromdDate(context),
                        child: Text(
                            "od ${dFormat.format(removalController.fromDate.value)}"),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                        onPressed: () => _selectToDate(context),
                        child: Text(
                            "do ${dFormat.format(removalController.toDate.value)}"),
                      ),
                    ],
                  )
                : Container()),
            const SizedBox(
              width: 20.0,
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Pretrazi'),
            )
          ],
        ),
      ),
    );
  }
}
