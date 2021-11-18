import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homescreen.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  List<DocumentSnapshot> orders = <DocumentSnapshot>[];
  var udata = FirebaseAuth.instance.currentUser;
  bool isLoading = true;
  void showDialog(Map<String, dynamic> mp) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 300,
            child: SizedBox.expand(
              child: Container(
                child: Text("data"),
              ),
            ),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  getData() async {
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection("CurrentOrders").get();
    setState(() {
      for (var it in snap.docs) {
        if (it.get("userid") == udata!.uid) {
          orders.add(it);
        }
      }
    });
    print(orders.length);
    isLoading = false;
  }

  @override
  initState() {
    super.initState();
    getData();
    // Add listeners to this class
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen())),
                  },
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 10,
                      color: Colors.white,
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.orange,
                        ),
                      )),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01),
              alignment: Alignment.center,
              child: Text(
                "Order History",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.aspectRatio * 60),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            isLoading == true
                ? Container(
                    child: Text("Loading"),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          print(orders[index]["totalprice"]);
                          return GestureDetector(
                            onTap: () =>
                                {showDialog(orders[index]["dishandcount"])},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                // borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "27/10/2000",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  const Text(
                                    "Tap to view details",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    '\u{20B9} ${orders[index]["totalprice"]}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }))
          ],
        ),
      ),
    );
  }
}
