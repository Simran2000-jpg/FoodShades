import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shades_food/screens/admin/admin_orderlist.dart';

import '../../splashscreen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FoodShadesAdmin'),
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
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {},
        child: Text('ADD ITEM'),
      ),
      body: Admin_OrderList(),
    );
  }
}
