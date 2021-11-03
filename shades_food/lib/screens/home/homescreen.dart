import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shades_food/screens/home/FoodTile.dart';
import 'package:shades_food/screens/home/user_orderlist.dart';

import '../../splashscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> item = [
    {'title': 'Pizza', 'image': 'assets/astro.png', 'price': '80'},
    {'title': 'Dosa', 'image': 'assets/astro.png', 'price': '100'},
    {'title': 'Choumein', 'image': 'assets/astro.png', 'price': '60'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(
          Icons.store,
          color: Colors.white,
          size: 27,
        ),
        onPressed: () => {},
      ),
      backgroundColor: const Color.fromRGBO(235, 235, 235, 1),
      body: Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Card(
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
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    //signOutUser();
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SplashScreen()));
                  },
                  child: Card(
                      margin: const EdgeInsets.only(left: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 10,
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.exit_to_app,
                          size: 30,
                          color: Colors.orange,
                        ),
                      )),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(Icons.star, color: Colors.white, size: 15),
                      Text(
                        "4.7",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: const Text(
                      "Recommended",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: const Text("Popular"),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: const Text("Noodles"),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
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
            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            //   // child: SingleChildScrollView(
            //   //   child: Column(
            //   //     children: [
            //   //       // ignore: prefer_const_constructors
            //   //       const FoodTile(
            //   //         title: "Soda Soups",
            //   //         image: "assets/astro.png",
            //   //         price: "10",
            //   //       ),
            //   //       const FoodTile(
            //   //         title: "Soda Soups",
            //   //         image: "assets/astro.png",
            //   //         price: "10",
            //   //       ),
            //   //       const FoodTile(
            //   //         title: "Soda Soups",
            //   //         image: "assets/astro.png",
            //   //         price: "10",
            //   //       ),
            //   //     ],
            //   //   ),
            //   // ),
            //   child: ListView.builder(
            //     shrinkWrap: true,
            //     itemCount: item.length,
            //     itemBuilder: (context, index) {
            //       return FoodTile(
            //         title: item[index]["title"].toString(),
            //         image: item[index]["image"].toString(),
            //         price: item[index]["price"].toString(),
            //       );
            //     },
            //   ),
            // )
            UserOrderList(),
          ],
        ),
      ),
    );
  }
}
