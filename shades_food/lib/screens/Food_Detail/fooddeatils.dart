// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shades_food/screens/cart/cart_screen.dart';
import 'package:shades_food/screens/home/homescreen.dart';

// ignore: must_be_immutable
class FoodDetail extends StatefulWidget {
  String image, title, price, description, time, rate;
  String id;
  FoodDetail({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.id,
    required this.time,
    required this.rate,
  }) : super(key: key);

  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  final firestoreInstance = FirebaseFirestore.instance.collection('Dish');
  var udata = FirebaseAuth.instance.currentUser;

  final counter = ValueNotifier<int>(0);
  int currentprice = 0;
  bool isLoading = true;
  String id = "";
  getData() async {
    // print(uid);
    final CollectionReference snap =
        FirebaseFirestore.instance.collection("cart");
    var udata = FirebaseAuth.instance.currentUser;

    final Query cart = snap
        .where("userid", isEqualTo: udata!.uid)
        .where("dishid", isEqualTo: widget.id.toString().trim());
    var data = await cart.get();
    if (data.docs.length > 0) {
      setState(() {
        id = data.docs.elementAt(0).id;
        counter.value = data.docs.elementAt(0).get("count");
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  var tp = 0;
  @override
  initState() {
    super.initState();
    tp = int.parse(widget.price);
    currentprice = int.parse(widget.price);
    getData();
    // Add listeners to this class
  }

  void totalpriceinc() {
    setState(() {
      counter.value++;
      tp = counter.value * currentprice;
    });
    update();
  }

  void totalpricedec() {
    setState(() {
      if (counter.value >= 1) {
        counter.value--;

        if (counter.value == 0) {
          FirebaseFirestore.instance.collection("cart").doc(id).delete();
        }
        tp = max(counter.value * currentprice, currentprice);
      }
    });
    if (counter.value > 0) update();
  }

  void uploadData() {
    FirebaseFirestore.instance.collection('cart').add(
        {'count': 1, 'dishid': widget.id, 'userid': udata!.uid}).then((value) {
      setState(() {
        id = value.id;
      });
    });
    setState(() {
      counter.value = 1;
    });
  }

  void update() {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(id)
        .update({"count": counter.value});
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.id);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(
          Icons.store,
          color: Colors.white,
          size: 27,
        ),
        onPressed: () => {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => CartScreen()))
        },
      ),
      backgroundColor: Colors.orange,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              child: GestureDetector(
                onTap: () => {
                  Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => HomeScreen())),
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
            Container(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Row(children: [
                            const Icon(Icons.lock_clock),
                            Text(
                              "${widget.time}min",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.03),
                            ),
                          ])),
                          Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.1),
                              child: Row(children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Text(
                                  widget.rate,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.03),
                                ),
                              ])),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.aspectRatio * 30),
                        child: Text(
                          '\u{20B9} $tp',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.03),
                        ),
                      ),
                      isLoading == true
                          ? CircularProgressIndicator(
                              color: Colors.orange,
                            )
                          : counter.value != (0)
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.06),
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              255, 242, 230, .7),
                                          border: Border.all(
                                              color: Colors.orange, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: GestureDetector(
                                        // padding: EdgeInsets.all(25),
                                        // alignment: Alignment.center,
                                        child: const Icon(Icons.remove),
                                        onTap: () => {totalpricedec()},
                                      ),
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable: counter,
                                      builder: (context, value, widget) {
                                        return Container(
                                            padding: EdgeInsets.all(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04),
                                            child: Text(value.toString()));
                                      },
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              255, 242, 230, .7),
                                          border: Border.all(
                                              color: Colors.orange, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: GestureDetector(
                                        // padding: EdgeInsets.all(25),
                                        // alignment: Alignment.center,
                                        child: const Icon(Icons.add),
                                        onTap: () => {totalpriceinc()},
                                      ),
                                    ),
                                  ],
                                )
                              : Container(
                                  height: 50.0,
                                  margin: const EdgeInsets.all(10),
                                  child: RaisedButton(
                                    onPressed: () => {uploadData()},
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(80.0)),
                                    padding: const EdgeInsets.all(0.0),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          color: Colors.orange[300],
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                            maxWidth: 200.0, minHeight: 50.0),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "Add to cart",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.05,
                            left: MediaQuery.of(context).size.width * 0.05),
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "About",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01,
                            left: MediaQuery.of(context).size.width * 0.05),
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.description,
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .12,
                      )
                    ],
                  ),
                ),
              ),
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .25,
              ),
              height: MediaQuery.of(context).size.height * 0.75,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .15),
              alignment: Alignment.topCenter,
              child: Image.network(
                widget.image,
                height: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
