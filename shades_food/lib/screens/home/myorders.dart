import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

import 'homescreen.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  List<DocumentSnapshot> orders = <DocumentSnapshot>[];
  List<DocumentSnapshot> dish = <DocumentSnapshot>[];
  List<int> fb = <int>[];

  var udata = FirebaseAuth.instance.currentUser;
  bool isLoading = true;

  getData() async {
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection("CurrentOrders").get();
    QuerySnapshot snap2 =
        await FirebaseFirestore.instance.collection("Dish").get();
    QuerySnapshot snap3 =
        await FirebaseFirestore.instance.collection("FeedBack").get();
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
      for (var it in orders) {
        bool f = false;
        for (var tm in snap3.docs) {
          if (it.id == tm.get("orderid") &&
              tm.get("customer_id") == udata!.uid) {
            // print(tm.get("orderid"));
            // print(it.id);
            // print(tm.get("customer_id"));
            // print(tm.get("rating"));

            fb.add(tm.get("rating"));
            f = true;
            break;
          }
        }
        if (!f) fb.add(0);
      }
    });
    print(fb.length);
    for (var x in fb) print(x);
    isLoading = false;
  }

  @override
  initState() {
    super.initState();
    getData();
    // print(orders.length);
    // print(dish.length);
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
                : orders.length > 0
                    ? Expanded(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  // image: AssetImage(
                                                  //     'assets/astro.png'),
                                                  image: NetworkImage(
                                                      dish[index]["imageurl"]),
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
                                              "${dish[index]["name"].toString()}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 1,
                                            ),
                                            Text(
                                              "Quantity: ${orders[index]["dishandcount"][0]["count"].toString()}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Ordered on",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            ),
                                            Text(
                                              " ${dt.toDate().toString().trim().substring(0, dt.toDate().toString().trim().length - 7)}",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey),
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
                                        Text(
                                          "\u{20B9} ${(int.parse(dish[index]["price"]) * (int.parse(orders[index]["dishandcount"][0]["count"]))).toString()}",
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        fb[index] == 0
                                            ? GestureDetector(
                                                onTap: () {
                                                  _showRatingAppDialog(
                                                      orders[index].id, index);
                                                },
                                                child: Text(
                                                  "Rate",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              )
                                            : Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.green,
                                                    size: 14,
                                                  ),
                                                  Text(
                                                    fb[index].toString() + ".0",
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }))
                    : Container(
                        child: Text("No orders yet"),
                      ),
          ],
        ),
      ),
    );
  }

  double roundOffToXDecimal(double number, {int numberOfDecimal = 1}) {
    String numbersAfterDecimal = number.toString().split('.')[1];
    if (numbersAfterDecimal != '0') {
      int existingNumberOfDecimal = numbersAfterDecimal.length;
      number += 1 / (10 * pow(10, existingNumberOfDecimal));
    }

    return double.parse(number.toStringAsFixed(numberOfDecimal));
  }

  var _auth = FirebaseAuth.instance;
  void _showRatingAppDialog(orderid, index) {
    final _ratingDialog = RatingDialog(
      // ratingColor: Colors.amber,
      title: Text(
        'Rate this dish and tell others what you think.',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      starSize: 25,
      image: Image.asset(
        "assets/saute.png",
        height: 200,
      ),
      submitButtonText: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) async {
        var customer_id = _auth.currentUser!.uid;
        var customer = await FirebaseFirestore.instance
            .collection('users')
            .doc(customer_id)
            .get();
        print('rating: ${response.rating}, '
            'comment: ${response.comment}');
        var num = await FirebaseFirestore.instance
            .collection('OrderNo')
            .doc('OrderCount')
            .get();
        if (response.rating > 0) {
          setState(() {
            fb[index] = response.rating.ceil();
          });
          await FirebaseFirestore.instance.collection('FeedBack').add({
            'rating': response.rating.ceil(),
            'comment': response.comment,
            'customer_id': _auth.currentUser!.uid,
            'orderno': num.get('current') - 1,
            'orderid': orderid,
            'customer_name': customer.get('name'),
          });
          var r = await FirebaseFirestore.instance
              .collection('Rating')
              .doc('CurrentRating')
              .get();
          double rating = r.get('rating');
          rating = (rating * 5 + response.rating) / 6;
          var rrating = roundOffToXDecimal(rating);
          rating.truncateToDouble();
          await FirebaseFirestore.instance
              .collection('Rating')
              .doc('CurrentRating')
              .set({'rating': rrating});
        }
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );
  }
}
