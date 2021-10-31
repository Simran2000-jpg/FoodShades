import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shades_food/screens/admin/adminscreen.dart'; //adminScreen
import 'package:shades_food/homescreen.dart'; //homeScreen
import 'package:flutter/material.dart';
import 'package:shades_food/screens/auth/PhoneVerifPage.dart';
import 'package:shades_food/screens/auth/SignUpPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String role = '';
  String _uid = "";

  @override
  void initState() {
    _checkRole();
    //Future.delayed(Duration(seconds: 5));
    super.initState();
  }

  void _checkRole() async {
    _uid = '';
    role = '';
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      navigateNext(PhoneVerifPage());
      return;
    }
    _uid = user.uid;
    print('UserID ----------------------------------------- ' + _uid);

    if (_uid != "") {
      final DocumentSnapshot snap =
          await FirebaseFirestore.instance.collection('users').doc(_uid).get();

      // role = snap['role'];
      print("############### " + snap['role']);
      setState(() {
        role = snap['role'];
      });
    }
    print('Role >>>>>>>>>>>>>>>>>>>>>>>>>>>>> ' + role);
    if (role == 'user') {
      navigateNext(HomeScreen());
    } else if (role == 'admin') {
      navigateNext(AdminScreen());
    } else {
      navigateNext(PhoneVerifPage());
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
            Text('Splash Screen!!!'),
          ],
        ),
      ),
    );
  }
}
