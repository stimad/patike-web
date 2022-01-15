import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snickers/constants/controllers.dart';
import 'package:snickers/data/rest/requests.dart';
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
    findSnickers(statisticsController.getSearchFilter());
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

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
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
              controller: statisticsController.searchModelCtrl,
              // onChanged: (value) =>
              //     statisticsController.setSearchSnickersModel(value),
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
              controller: statisticsController.searchColorCtrl,
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
              controller: statisticsController.searchSizeCtrl,
              decoration: const InputDecoration(
                hintText: 'Unesi velicinu patike',
                labelText: 'Velicina patike',
              ),
            ),
            Row(
              children: [
                Obx(
                  () => Checkbox(
                      value: statisticsController.searchOnlyAvailable.value,
                      onChanged: (value) =>
                          statisticsController.setSearchOnlyAvailable(value!)),
                ),
                const Text("Samo dostupne")
              ],
            ),
            const SizedBox(
              width: 20.0,
              height: 5.0,
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
