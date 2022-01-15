import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  const Spinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 0.5)),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
