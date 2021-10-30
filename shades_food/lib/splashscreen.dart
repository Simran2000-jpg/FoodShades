import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shades_food/screens/admin/adminscreen.dart'; //adminScreen
import 'package:shades_food/confirm.dart'; //homeScreen
import 'package:flutter/material.dart';
import 'package:shades_food/screens/auth/PhoneVerifPage.dart';
import 'package:shades_food/screens/auth/SignUpPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String role = 'user';
  String _uid = "";

  @override
  void initState() {
    Future.delayed(Duration(seconds: 5));
    super.initState();
    _checkRole();
  }

  void _checkRole() async {
    //FirebaseAuth.instance.signOut();
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      navigateNext(PhoneVerifPage());
    }
    _uid = user == null ? "" : user.uid;
    print('UserID ----------------------------------------- ' + _uid);
    // if (_uid == "") {
    //   navigateNext(SignUpPage());
    //   return;
    // }
    final DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();

    setState(() {
      // role = snap['role'];
      role = snap.toString().contains('role') ? snap['role'] : '';
    });
    print('Role >>>>>>>>>>>>>>>>>>>>>>>>>>>>> ' + role);
    if (role == 'user') {
      navigateNext(ConfirmPage());
    } else if (role == 'admin') {
      navigateNext(AdminScreen());
    }
  }

  void navigateNext(Widget route) {
    Timer(Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => route));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome'),
          ],
        ),
      ),
    );
  }
}
