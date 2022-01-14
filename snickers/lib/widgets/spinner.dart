import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snickers/constants/colors.dart';
import 'package:snickers/helpers/responsivness.dart';

class Spinner extends StatelessWidget {
  const Spinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: _createSpinnerWithBackground(context));
  }

  Widget _createSpinnerWithBackground(BuildContext context) {
    return Expanded(
        child: Container(
      child: _createSpinner(context),
      decoration:
          const BoxDecoration(color: Color.fromRGBO(220, 220, 220, 0.5)),
    ));
  }

  Widget _createSpinner(BuildContext context) {
    return Center(
        child: SpinKitFadingCircle(
      size: ResponsiveWidget.isCustomScreen(context) ? 100.0 : 20.0,
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(color: lightBlue),
        );
      },
    ));
  }
}
