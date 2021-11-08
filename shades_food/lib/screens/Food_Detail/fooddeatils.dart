// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shades_food/screens/cart/cart_screen.dart';
import 'package:shades_food/screens/home/homescreen.dart';

int currentprice = 0;

// ignore: must_be_immutable
class FoodDetail extends StatefulWidget {
  String image, title, price;
  FoodDetail({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
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
    currentprice = int.parse(widget.price);
    print(currentprice);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(
          Icons.store,
          color: Colors.white,
          size: 27,
        ),
        onPressed: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CartScreen()))
        },
      ),
      backgroundColor: Colors.orange,
      body: Container(
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
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
            Container(
              padding: EdgeInsets.only(top: 90),
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
                          "50min",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.03),
                        ),
                      ])),
                      Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.1),
                          child: Row(children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Text(
                              "4.8",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.height *
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
                          fontSize: MediaQuery.of(context).size.height * 0.03),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        onPressed: () => totalpricedec(),
                        child: const Icon(Icons.remove),
                      ),
                      ValueListenableBuilder(
                        valueListenable: counter,
                        builder: (context, value, widget) {
                          return Container(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.04),
                              child: Text(value.toString()));
                        },
                      ),
                      RaisedButton(
                        onPressed: () => totalpriceinc(),
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05,
                        left: MediaQuery.of(context).size.width * 0.05),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "About",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.05),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "sx snc ans a x na j a ka  a x s xa sb sab ba b a sb ca scb sb a cm acasasaxascasjc ans ca xs cba csba sa  bas cb sb asb cb scba sbc asb b",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .25),
              // height: MediaQuery.of(context).size.height * 0.55,
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
              child: Image.asset(
                "assets/astro.png",
                height: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
