import 'package:flutter/material.dart';
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
              width: 20.0,
              height: 20.0,
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
