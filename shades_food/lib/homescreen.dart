import 'dart:io';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shades_food/order.dart';
import 'package:shades_food/splashscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () async {
              //signOutUser();
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SplashScreen()));
            },
          )
        ],
        centerTitle: true,
      ),
      floatingActionButton: ElevatedButton(
        child: Text('Order Item'),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => OrderPage()));
        },
      ),
      body: Center(
        child: Text('List of Dishes to be displayed Here'),
      ),
    );
  }
}
