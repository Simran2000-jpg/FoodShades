import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shades_food/screens/admin/adminscreen.dart'; //adminScreen
// import 'package:shades_food/homescreen.dart'; //homeScreen
import 'package:flutter/material.dart';
import 'package:shades_food/screens/auth/PhoneVerifPage.dart';
import 'package:shades_food/screens/auth/SignUpPage.dart';
import 'package:shades_food/screens/home/homescreen.dart';
import 'package:shimmer/shimmer.dart';

import 'screens/Food_Detail/fooddeatils.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Tween<double> _sizeTween = Tween<double>(begin: 20, end: 150);
  String role = '';
  String _uid = "";

  @override
  void initState() {
    // Future.delayed(Duration(seconds: 5));
    _checkRole();
    //
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
      navigateNext(FoodDetail());
    } else if (role == 'admin') {
      navigateNext(AdminScreen());
    } else {
      navigateNext(PhoneVerifPage());
    }
  }

  void navigateNext(Widget route) {
    Timer(Duration(milliseconds: 5000), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => route));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFC495),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder(
                tween: _sizeTween,
                duration: Duration(milliseconds: 1000),
                builder: (_, size, __) {
                  return Container(
                    height: size as double,
                    width: size as double,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/astro.png'),
                      // image: AssetImage('./images/foodshades.jpg',
                      //     package: "com.example.shades_food"),
                      fit: BoxFit.fill,
                    )),
                  );
                },
              ),
              SizedBox(
                height: 3,
              ),
              Shimmer.fromColors(
                baseColor: Color(0xFF1E1E29),
                highlightColor: Color(0xFFFFF7C6),
                child: Text(
                  "FOODSHADES",
                  style: TextStyle(
                    fontFamily: 'Montserrat Bold',
                    color: Color(0xFF1E1E29),
                    fontSize: 18,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
        )
        // body: Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text('Splash Screen!!!'),
        //     ],
        //   ),
        // ),
        );
  }
}
