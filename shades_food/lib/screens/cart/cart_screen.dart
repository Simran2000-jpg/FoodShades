import 'package:flutter/material.dart';
import 'package:shades_food/screens/Food_Detail/fooddeatils.dart';
import 'package:shades_food/screens/home/homescreen.dart';
import 'package:shades_food/screens/payment.dart';

int currentprice = 0;

// ignore: must_be_immutable
class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final counter = ValueNotifier<int>(1);
  var tp = currentprice;
  void totalpriceinc() {
    setState(() {
      counter.value++;
      tp = counter.value * currentprice;
    });
  }

  void totalpricedec() {
    setState(() {
      if (counter.value > 1) {
        counter.value--;
        tp = counter.value * currentprice;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.bottomCenter, children: [
        Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(context,
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
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01),
              alignment: Alignment.center,
              child: Text(
                "Your Cart",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.aspectRatio * 60),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03),
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset(
                              "assets/astro.png",
                              height: 100,
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: const [
                                    Text(
                                      "Noodles",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 20),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '\u{20B9}20',
                                        // textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 15,
                                            color: Colors.orange),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.06),
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(255, 232, 209, 1),
                                        border: Border.all(
                                            color: Colors.deepOrange, width: 1),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: GestureDetector(
                                      // padding: EdgeInsets.all(25),
                                      // alignment: Alignment.center,
                                      child: Icon(Icons.remove),
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
                                                  0.02),
                                          child: Text(value.toString()));
                                    },
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(255, 232, 209, 1),
                                        border: Border.all(
                                            color: Colors.deepOrange, width: 1),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: GestureDetector(
                                      // padding: EdgeInsets.all(25),
                                      // alignment: Alignment.center,
                                      child: Icon(Icons.add),
                                      onTap: () => {totalpriceinc()},
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset(
                              "assets/astro.png",
                              height: 100,
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: const [
                                    Text(
                                      "Noodles",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 20),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '\u{20B9}20',
                                        // textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 15,
                                            color: Colors.orange),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.06),
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(255, 232, 209, 1),
                                        border: Border.all(
                                            color: Colors.deepOrange, width: 1),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: GestureDetector(
                                      // padding: EdgeInsets.all(25),
                                      // alignment: Alignment.center,
                                      child: Icon(Icons.remove),
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
                                                  0.02),
                                          child: Text(value.toString()));
                                    },
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(255, 232, 209, 1),
                                        border: Border.all(
                                            color: Colors.deepOrange, width: 1),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: GestureDetector(
                                      // padding: EdgeInsets.all(25),
                                      // alignment: Alignment.center,
                                      child: Icon(Icons.add),
                                      onTap: () => {totalpriceinc()},
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height * .07,
          // color: Colors.amber,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                // flex: 2,
                child: Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Total Price",
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: MediaQuery.of(context).size.aspectRatio * 40),
                  ),
                ),
              ),
              Flexible(
                // flex: 3,
                child: Container(
                  color: Colors.orange,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Checkout",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.aspectRatio * 40),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
