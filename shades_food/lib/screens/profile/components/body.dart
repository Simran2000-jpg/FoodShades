import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:shades_food/order.dart';
import 'package:shades_food/screens/admin/adminscreen.dart';
import 'package:shades_food/screens/auth/PhoneVerifPage.dart';
import 'package:shades_food/screens/confirmPage.dart';
import 'package:shades_food/screens/feedbacks/feedback.dart';
import 'package:shades_food/screens/home/drawerstatus.dart';
import 'package:shades_food/screens/home/myorders.dart';
import 'package:shades_food/screens/profilepages/Dashboard.dart';
import 'package:shades_food/splashscreen.dart';

import 'profile_menu.dart';

class Body extends StatefulWidget {
  Body({required this.status});
  final statusCallback status;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();
  String storedPasscode = "123456";
  bool isAuthenticated = false;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFFFFE0B2)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '',
                    style: const TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                      onTap: () {
                        widget.status(false);
                      },
                      child: const Icon(Icons.close))
                ],
              ),
            ),
            // ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: "assets/icon/User.svg",
              press: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (builder) => ProfilePage()),
                )
              },
            ),
            ProfileMenu(
              text: "Current Orders",
              icon: "assets/icon/Bell.svg",
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderPage()));
              },
            ),
            ProfileMenu(
              text: "Order Hisory",
              icon: "assets/icon/Bell.svg",
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyOrder()));
              },
            ),

            ProfileMenu(
              text: "Admin",
              icon: "assets/icon/Settings.svg",
              press: () {
                _showLockScreen(
                  context,
                  opaque: false,
                  cancelButton: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('CANCEL')),
                );
              },
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icon/Log out.svg",
              press: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => PhoneVerifPage()));
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
