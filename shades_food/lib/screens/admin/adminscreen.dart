import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shades_food/screens/admin/additemAdmin.dart';
import 'package:shades_food/screens/admin/admin_dishlist.dart';
import 'package:shades_food/screens/admin/currentOrdersAdmin.dart';
import 'package:shades_food/screens/feedbacks/feedback.dart';

import '../../splashscreen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int index = 0;
  final screens = [
    Admin_DishList(),
    CurrentOrdersAdmin(),
    FeedBackScreen(),
  ];
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
          backgroundColor: Color(0xFFFFE0B2),
          elevation: 15,
          title: Text("ADMIN"),
          centerTitle: true,
          // actions: [
          //   IconButton(
          //       icon: Icon(Icons.logout),
          //       onPressed: () async {
          //         //signOutUser();
          //         await FirebaseAuth.instance.signOut();
          //         Navigator.pushReplacement(context,
          //             MaterialPageRoute(builder: (context) => SplashScreen()));
          //       }),
          // ],
        ),
        body: screens[index],

        // TabBarView(
        //   children: [Admin_DishList(), CurrentOrdersAdmin()],
        // ),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              backgroundColor: Color(0xFFFFE0B2),
              indicatorColor: Colors.orange,
              labelTextStyle: MaterialStateProperty.all(
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
          child: NavigationBar(
            height: 60,
            selectedIndex: index,
            onDestinationSelected: (index) => setState(() {
              this.index = index;
            }),
            destinations: [
              NavigationDestination(icon: Icon(Icons.add), label: 'DISH LIST'),
              NavigationDestination(
                  icon: Icon(Icons.add), label: 'CURRENT ORDERS'),
              NavigationDestination(icon: Icon(Icons.add), label: 'FEEDBACK'),
            ],
          ),
        ),
      ),
    );
  }
}
