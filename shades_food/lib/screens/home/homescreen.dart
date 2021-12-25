import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shades_food/screens/cart/cart_screen.dart';
import 'package:shades_food/screens/home/user_orderlist.dart';
import 'package:shades_food/screens/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String rating = "-";
  bool isDrawerOpen = false;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  void getRating() async {
    var r = await FirebaseFirestore.instance
        .collection('Rating')
        .doc('CurrentRating')
        .get();
    setState(() {
      rating = (r.get('rating')).toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // print('-----------------------------------' +
    //     FirebaseAuth.instance.currentUser!.uid);
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pop(context);
    }
    super.initState();
    getRating();
  }

  void onclick(status) {
    // print(status);
    setState(() {
      if (status == true) {
        xOffset = MediaQuery.of(context).size.width * .001;
        yOffset = MediaQuery.of(context).size.height * .73;
        scaleFactor = 1;
        isDrawerOpen = true;
      } else {
        setState(() {
          xOffset = 0;
          yOffset = 0;
          scaleFactor = 1;
          isDrawerOpen = false;
        });
      }
    });
  }

  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFE699),
      body: Container(
        child: Stack(
          children: [
            ProfileScreen(status: onclick),
            AnimatedContainer(
              transform: Matrix4.translationValues(xOffset, yOffset, 0)
                ..scale(scaleFactor)
                ..rotateY(isDrawerOpen ? 0 : 0),
              duration: Duration(milliseconds: 250),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Color(0xF1DDDDDD),
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: Offset(0, 4)),
              ]),
              child: GestureDetector(
                onVerticalDragEnd: (DragEndDetails dragEndDetails) {
                  // print(dragEndDetails.velocity.pixelsPerSecond.dx);
                  // print(dragEndDetails.velocity.pixelsPerSecond.dy);
                  if (dragEndDetails.velocity.pixelsPerSecond.dy > 0) {
                    isDrawerOpen = true;
                    // print(isDrawerOpen);
                    onclick(isDrawerOpen);
                  } else {
                    isDrawerOpen = false;
                    // print(isDrawerOpen);
                    onclick(isDrawerOpen);
                  }
                },
                child: Scaffold(
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Colors.orange,
                    child: const Icon(
                      Icons.store,
                      color: Colors.white,
                      size: 27,
                    ),
                    onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CartScreen()))
                    },
                  ),
                  // backgroundColor: const Color.fromRGBO(235, 235, 235, 1),
                  // backgroundColor: Color(0xff000000),

                  body: Stack(children: [
                    Container(
                      color: Colors.white,

                      // decoration: BoxDecoration(
                      //         image: DecorationImage(
                      //   image: AssetImage("assets/bgsp.jpg"),
                      //   fit: BoxFit.cover,
                      // ))
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * .06,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => {onclick(!isDrawerOpen)},
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Card(
                                        margin: const EdgeInsets.only(left: 15),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        elevation: 10,
                                        child: const Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.person,
                                            size: 30,
                                            color: Colors.orange,
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .02),
                          Container(
                            height: MediaQuery.of(context).size.height * .128,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          bottom: 4.0,
                                          top: 20),
                                      child: const Text(
                                        "Cafe 96",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat Bold'),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          bottom: 15.0,
                                          top: 2.0),
                                      child: Text(
                                        "MNNIT ALLAHABAD",
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat Bold'),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.star,
                                          color: Colors.white, size: 15),
                                      Text(
                                        rating,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          topLeft: Radius.circular(10)),
                                      color: Colors.green),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * .08,
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 1.0, top: 10),
                            child: const Text(
                              "Dishes Available",
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'MenuIcon'),
                            ),
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height * .65,
                              child:
                                  SingleChildScrollView(child: UserOrderList()))
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
