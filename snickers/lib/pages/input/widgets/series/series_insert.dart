import 'package:flutter/material.dart';
import 'package:snickers/constants/controllers.dart';
import 'package:snickers/data/rest/requests.dart';
import 'package:snickers/dtos/snickers.dart';
import 'package:snickers/utils/utils.dart';

class SeriesInsert extends StatelessWidget {
  SeriesInsert({Key? key}) : super(key: key);

  final FocusNode _modelFocusNode = FocusNode();
  final FocusNode _colorFocusNode = FocusNode();
  final FocusNode _minSizeFocusNode = FocusNode();
  final FocusNode _maxSizeFocusNode = FocusNode();
  final FocusNode _numFocusNode = FocusNode();

  _nextFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  _submitForm(BuildContext context) {
    List<Snickers> snickersList = [];
    var smallestSizeSnickers = Snickers(
        0,
        newSnickersController.seriesInsertModelCtrl.text,
        newSnickersController.seriesInsertColorCtrl.text,
        int.tryParse(newSnickersController.seriesInsertMinSizeCtrl.text),
        int.tryParse(newSnickersController.seriesInsertCountCtrl.text),
        0);
    var biggestSizeSnickers = Snickers(
        0,
        newSnickersController.seriesInsertModelCtrl.text,
        newSnickersController.seriesInsertColorCtrl.text,
        int.tryParse(newSnickersController.seriesInsertMaxSizeCtrl.text),
        int.tryParse(newSnickersController.seriesInsertCountCtrl.text),
        0);
    if (!areSnickersValuesOK(smallestSizeSnickers) ||
        !areSnickersValuesOK(biggestSizeSnickers)) {
      showErrorDialog(context, "Greska", "Unesene vrednosti nisu dobre.");
      return;
    }
    int biggestSize =
        int.tryParse(newSnickersController.seriesInsertMaxSizeCtrl.text)!;
    int smallestSize =
        int.tryParse(newSnickersController.seriesInsertMinSizeCtrl.text)!;
    for (int i = smallestSize; i <= biggestSize; i++) {
      snickersList.add(Snickers(
          0,
          newSnickersController.seriesInsertModelCtrl.text,
          newSnickersController.seriesInsertColorCtrl.text,
          i,
          int.tryParse(newSnickersController.seriesInsertCountCtrl.text),
          0));
    }
    navigationController.setIsLoading(true);
    insertSnickersSeries(context, snickersList);
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
          "Unos serije",
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
                  controller: newSnickersController.seriesInsertModelCtrl,
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
                  controller: newSnickersController.seriesInsertColorCtrl,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  focusNode: _colorFocusNode,
                  onFieldSubmitted: (String value) {
                    _nextFocus(context, _minSizeFocusNode);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Unesi boju patike',
                    labelText: 'Boja patike',
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller:
                            newSnickersController.seriesInsertMinSizeCtrl,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        focusNode: _minSizeFocusNode,
                        onFieldSubmitted: (String value) {
                          _nextFocus(context, _numFocusNode);
                        },
                        validator: (String? value) => _validateNumber(value),
                        decoration: const InputDecoration(
                          hintText: 'Unesi minimalnu velicinu patike iz serije',
                          labelText: 'Minimalna veličina patike',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller:
                            newSnickersController.seriesInsertMaxSizeCtrl,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        focusNode: _maxSizeFocusNode,
                        onFieldSubmitted: (String value) {
                          _nextFocus(context, _numFocusNode);
                        },
                        validator: (String? value) => _validateNumber(value),
                        decoration: const InputDecoration(
                          hintText:
                              'Unesi maksimalnu velicinu patike iz serije',
                          labelText: 'Maksimalna veličina patike',
                        ),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: newSnickersController.seriesInsertCountCtrl,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: _numFocusNode,
                  validator: (String? value) => _validateNumber(value),
                  decoration: const InputDecoration(
                    hintText: 'Unesi broj komada po veličini u seriji',
                    labelText: 'Komada',
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                  height: 5.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    _submitForm(context);
                  },
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
