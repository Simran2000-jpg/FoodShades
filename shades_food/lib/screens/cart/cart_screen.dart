import 'package:flutter/material.dart';
import 'package:shades_food/screens/Food_Detail/fooddeatils.dart';
import 'package:shades_food/screens/home/homescreen.dart';
import 'package:shades_food/screens/payment.dart';

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
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
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
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
            alignment: Alignment.center,
            child: Text(
              "Your Cart",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.aspectRatio * 60),
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
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
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: const [
                              Text(
                                "Noodles",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 20),
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
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.06),
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: RaisedButton(
                            onPressed: () => totalpricedec(),
                            // child: const Icon(
                            //   Icons.remove,
                            //   textDirection: TextDirection.ltr,
                            // ),
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: counter,
                          builder: (context, value, widget) {
                            return Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.02),
                                child: Text(value.toString()));
                          },
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: RaisedButton(
                            onPressed: () => totalpriceinc(),
                            // child: const Icon(Icons.add),
                          ),
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
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: const [
                              Text(
                                "Noodles",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 20),
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
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.06),
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: RaisedButton(
                            onPressed: () => totalpricedec(),
                            // child: const Icon(
                            //   Icons.remove,
                            //   textDirection: TextDirection.ltr,
                            // ),
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: counter,
                          builder: (context, value, widget) {
                            return Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.02),
                                child: Text(value.toString()));
                          },
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: RaisedButton(
                            onPressed: () => totalpriceinc(),
                            // child: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Container(
            height: 50.0,
            margin: EdgeInsets.all(10),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Payment(
                              price: 0,
                            )));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              padding: EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.deepOrange, Colors.orangeAccent],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: const Text(
                    "Proceed to Checkout",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
