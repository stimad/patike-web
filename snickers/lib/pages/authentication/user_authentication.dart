import 'package:flutter/material.dart';
import 'package:snickers/constants/controllers.dart';

class UserAuthentication extends StatelessWidget {
  UserAuthentication({Key? key}) : super(key: key);

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  _nextFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  _authorize(BuildContext context) {
    authController.authenticate(context);
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
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text("Prijava"),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              focusNode: _usernameFocusNode,
              onFieldSubmitted: (String value) {
                _nextFocus(context, _passwordFocusNode);
              },
              controller: authController.authUsernameCtrl,
              validator: (String? value) => _validateNonEmpty(value),
              decoration: const InputDecoration(
                hintText: 'Unesi korisničko ime',
                labelText: 'Korisničko ime',
              ),
            ),
            TextFormField(
              obscureText: true,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              focusNode: _passwordFocusNode,
              controller: authController.authPasswordCtrl,
              decoration: const InputDecoration(
                hintText: 'Unesi lozinku',
                labelText: 'Lozinka',
              ),
            ),
            const SizedBox(
              width: 20.0,
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () => _authorize(context),
              child: const Text('Prijavi se'),
            ),
          ],
        ),
      ),
    );
  }
}
