import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shades_food/screens/admin/additemAdmin.dart';
import 'package:shades_food/screens/admin/admin_orderlist.dart';
import 'package:shades_food/screens/admin/currentOrdersAdmin.dart';

import '../../splashscreen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: ElevatedButton(
          style: ButtonStyle(
              alignment: Alignment.center,
              backgroundColor: MaterialStateProperty.all<Color>(Colors.orange)),
          onPressed: () {
            print("ADD ITEM PRESSED_____________________");
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Upload()));
          },
          child: Text('ADD ITEM'),
        ),
        appBar: AppBar(
          elevation: 15,
          title: Text("ADMIN"),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  //signOutUser();
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SplashScreen()));
                }),
          ],
          bottom: TabBar(tabs: [
            Tab(
              text: 'Dishes',
            ),
            Tab(
              text: 'Current Orders',
            )
          ]),
        ),
        body: TabBarView(
          children: [Admin_OrderList(), CurrentOrdersAdmin()],
        ),
      ),
    );
  }
}
