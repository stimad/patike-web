import 'package:flutter/material.dart';
import 'package:snickers/constants/controllers.dart';
import 'package:snickers/data/rest/requests.dart';
import 'package:snickers/dtos/snickers.dart';
import 'package:snickers/utils/utils.dart';

class SingleInsert extends StatelessWidget {
  SingleInsert({Key? key}) : super(key: key);

  final FocusNode _modelFocusNode = FocusNode();
  final FocusNode _colorFocusNode = FocusNode();
  final FocusNode _sizeFocusNode = FocusNode();
  final FocusNode _numFocusNode = FocusNode();

  _nextFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  _submitForm(BuildContext context) {
    var snickers = Snickers(
        0,
        newSnickersController.singleInsertModelCtrl.text,
        newSnickersController.singleInsertColorCtrl.text,
        int.tryParse(newSnickersController.singleInsertSizeCtrl.text),
        int.tryParse(newSnickersController.singleInsertCountCtrl.text),
        0);
    if (!areSnickersValuesOK(snickers)) {
      showErrorDialog(context, "Greska", "Unesene vrednosti nisu dobre.");
      return;
    }
    navigationController.setIsLoading(true);
    insertSnickers(context, snickers);
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
    return Column(
      children: [
        const Text(
          "Pojedinačni unos",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Card(
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: newSnickersController.singleInsertModelCtrl,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  focusNode: _modelFocusNode,
                  onFieldSubmitted: (String value) {
                    _nextFocus(context, _colorFocusNode);
                  },
                  validator: (String? value) => _validateNonEmpty(value),
                  decoration: const InputDecoration(
                    hintText: 'Unesi model patike',
                    labelText: 'Model patike',
                  ),
                ),
                TextFormField(
                  controller: newSnickersController.singleInsertColorCtrl,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  focusNode: _colorFocusNode,
                  onFieldSubmitted: (String value) {
                    _nextFocus(context, _sizeFocusNode);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Unesi boju patike',
                    labelText: 'Boja patike',
                  ),
                ),
                TextFormField(
                  controller: newSnickersController.singleInsertSizeCtrl,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: _sizeFocusNode,
                  onFieldSubmitted: (String value) {
                    _nextFocus(context, _numFocusNode);
                  },
                  validator: (String? value) => _validateNumber(value),
                  decoration: const InputDecoration(
                    hintText: 'Unesi velicinu patike',
                    labelText: 'Velicina patike',
                  ),
                ),
                TextFormField(
                  controller: newSnickersController.singleInsertCountCtrl,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: _numFocusNode,
                  validator: (String? value) => _validateNumber(value),
                  decoration: const InputDecoration(
                    hintText: 'Unesi broj komada',
                    labelText: 'Komada',
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                  height: 5.0,
                ),
                ElevatedButton(
                  onPressed: () => _submitForm(context),
                  child: const Text('Unesi'),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
