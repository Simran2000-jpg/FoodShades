import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shades_food/screens/admin/additemAdmin.dart';
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
      floatingActionButton: ElevatedButton(
        style: ButtonStyle(
            alignment: Alignment.center,
            backgroundColor: MaterialStateProperty.all<Color>(Colors.orange)),
        onPressed: () {
          print("ADD ITEM PRESSED_____________________");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddItemAdmin()));
        },
        child: Text('ADD ITEM'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Row(
            children: [
              Card(
                  margin: const EdgeInsets.only(left: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 10,
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.orange,
                    ),
                  )),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  //signOutUser();
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SplashScreen()));
                },
                child: Card(
                    margin: const EdgeInsets.only(left: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 10,
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.exit_to_app,
                        size: 30,
                        color: Colors.orange,
                      ),
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Admin_OrderList(),
        ]),
      ),
    );
  }
}
