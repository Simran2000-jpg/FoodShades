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
  List<DocumentSnapshot> dish = <DocumentSnapshot>[];

  var udata = FirebaseAuth.instance.currentUser;
  bool isLoading = true;

  getData() async {
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection("CurrentOrders").get();
    QuerySnapshot snap2 =
        await FirebaseFirestore.instance.collection("Dish").get();
    setState(() {
      for (var it in snap.docs) {
        if (it.get("userid") == udata!.uid) {
          orders.add(it);
          for (var item in snap2.docs) {
            if (item.id == it.get("dishandcount")[0]["name"]) {
              dish.add(item);
            }
          }
        }
      }
    });

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
              margin: EdgeInsets.only(top: 5, bottom: 10),
              alignment: Alignment.center,
              child: Text(
                "Order History",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.aspectRatio * 60),
              ),
            ),
            isLoading == true
                ? Container(
                    child: Text("Loading"),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          Timestamp dt = orders[index]["time"];
                          return Container(
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              // border: Border.all(
                              //   color: Colors.black,
                              //   width: 1,
                              // ),
                              // borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/astro.png'),
                                              // image: NetworkImage(
                                              //     dish[index]["imageurl"]),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      height: 80,
                                      width: 80,
                                      child: null,
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "DISH"
                                          // orders[]
                                          // dish[index]["name"],
                                          ,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 1,
                                        ),
                                        Text(
                                          "Qunatity: ${orders[index]["dishandcount"][0]["count"].toString()}",
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Ordered on",
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                        Text(
                                          " ${dt.toDate().toString().trim().substring(0, dt.toDate().toString().trim().length - 7)}",
                                          style: TextStyle(
                                              fontSize: 10, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text(
                                    //   "\u{20B9} ${(int.parse(dish[index]["price"]) * (int.parse(orders[index]["dishandcount"][0]["count"]))).toString()}",
                                    //   style: TextStyle(
                                    //       color: Colors.orange,
                                    //       fontWeight: FontWeight.bold),
                                    // ),
                                    Text(
                                      "Delivered",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }))
          ],
        ),
      ),
    );
  }
}
