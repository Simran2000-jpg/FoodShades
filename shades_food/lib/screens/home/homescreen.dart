import 'package:anim_search_bar/anim_search_bar.dart';
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
  bool isDrawerOpen = false;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  @override
  void initState() {
    // TODO: implement initState
    print('-----------------------------------' +
        FirebaseAuth.instance.currentUser!.uid);
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pop(context);
    }
    super.initState();
  }

  void onclick(status) {
    // print(status);
    setState(() {
      if (status == true) {
        xOffset = MediaQuery.of(context).size.width * .01;
        yOffset = MediaQuery.of(context).size.height * .7;
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
      body: Stack(
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
                backgroundColor: const Color.fromRGBO(235, 235, 235, 1),
                body: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => {onclick(!isDrawerOpen)},
                              child: Card(
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
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 5, top: 20),
                                  child: const Text(
                                    "Bika Canteen",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20),
                                  child: Text(
                                    "MNNIT ALLAHABAD",
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Icon(Icons.star,
                                      color: Colors.white, size: 15),
                                  Text(
                                    "4.7",
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
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 5, top: 20),
                          child: const Text(
                            "Dishes Available",
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        UserOrderList()
                      ],
                    ),
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
