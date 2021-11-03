import 'package:flutter/material.dart';
import 'package:shades_food/screens/home/homescreen.dart';

class FoodDetail extends StatefulWidget {
  const FoodDetail({Key? key}) : super(key: key);

  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Soba Soup",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [Icon(Icons.lock_clock)],
                          )
                        ],
                      )
                    ],
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
