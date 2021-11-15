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
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  child: const Text(
                                    "Bika Canteen",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
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
                        SingleChildScrollView(
                          //changing scroll direction into horizontal
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: const Text(
                                  "Recommended",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: const Text("Popular"),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: const Text("Noodles"),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: const Text("Pizza"),
                              ),
                            ],
                          ),
                        ),
                        // InkWell(
                        //   onTap: () => {
                        //     Navigator.push(context,
                        //         MaterialPageRoute(builder: (context) => FoodDetail())),
                        //   },
                        //   child: Container(
                        //     padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                        //     child: StreamBuilder<QuerySnapshot>(
                        //         stream: FirebaseFirestore.instance
                        //             .collection('Dish')
                        //             .snapshots(),
                        //         builder: (BuildContext context,
                        //             AsyncSnapshot<QuerySnapshot> snapshot) {
                        //           if (snapshot.hasError) {
                        //             return Text('Something went wrong');
                        //           }
                        //           if (snapshot.connectionState == ConnectionState.waiting) {
                        //             return Text("Loading");
                        //           }
                        //           return snapshot.hasData
                        //               ? ListView(
                        //                   children: snapshot.data!.docs.map((document) {
                        //                     return FoodTile(
                        //                       title: document['name'],
                        //                       image: "assets/astro.png",
                        //                       price: document['price'],
                        //                     );
                        //                   }).toList(),
                        //                 )
                        //               : Text('Sorry! No dish available currently');
                        //         }),
                        //   ),
                        // )
                        // ignore: prefer_const_constructors
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
