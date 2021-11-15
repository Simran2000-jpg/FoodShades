import 'dart:async';

import 'package:flutter/material.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:shades_food/constants.dart';
import 'package:shades_food/screens/admin/adminscreen.dart';

class CheckPinAdmin extends StatefulWidget {
  const CheckPinAdmin({Key? key}) : super(key: key);

  @override
  _CheckPinAdminState createState() => _CheckPinAdminState();
}

class _CheckPinAdminState extends State<CheckPinAdmin> {
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();
  String storedPasscode = "123456";
  bool isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADMIN PIN'),
      ),
      body: _defaultLockScreenButton(context),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text('You are ${isAuthenticated ? '' : 'NOT'} authenticated'),
      //       _defaultLockScreenButton(context),
      //       _customColorsLockScreenButton(context)
      //     ],
      //   ),
      // ),
    );
  }

  _defaultLockScreenButton(BuildContext context) => MaterialButton(
        color: Theme.of(context).primaryColor,
        child: Text('Open Default Lock Screen'),
        onPressed: () {
          _showLockScreen(
            context,
            opaque: false,
            cancelButton: Text(
              'Cancel',
              style: const TextStyle(fontSize: 16, color: Colors.white),
              semanticsLabel: 'Cancel',
            ),
          );
        },
      );

  _showLockScreen(
    BuildContext context, {
    required bool opaque,
    CircleUIConfig? circleUIConfig,
    KeyboardUIConfig? keyboardUIConfig,
    required Widget cancelButton,
    List<String>? digits,
  }) {
    Navigator.push(
        context,
        PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (context, animation, secondaryAnimation) =>
              PasscodeScreen(
            title: Text(
              'Enter App Passcode',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            circleUIConfig: circleUIConfig,
            keyboardUIConfig: keyboardUIConfig,
            passwordEnteredCallback: _onPasscodeEntered,
            cancelButton: cancelButton,
            deleteButton: Text(
              'Delete',
              style: const TextStyle(fontSize: 16, color: Colors.white),
              semanticsLabel: 'Delete',
            ),
            shouldTriggerVerification: _verificationNotifier.stream,
            backgroundColor: Colors.black.withOpacity(0.8),
            digits: digits,
            passwordDigits: 6,
          ),
        ));
  }

  _onPasscodeEntered(String enteredPasscode) {
    if (enteredPasscode == storedPasscode) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => AdminScreen()));
    }
  }
}
