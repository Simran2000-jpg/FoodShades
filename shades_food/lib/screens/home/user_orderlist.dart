import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shades_food/screens/Food_Detail/fooddeatils.dart';
import 'package:shades_food/screens/home/FoodTile.dart';

class UserOrderList extends StatefulWidget {
  const UserOrderList({Key? key}) : super(key: key);

  @override
  _UserOrderListState createState() => _UserOrderListState();
}

class _UserOrderListState extends State<UserOrderList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Dish').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              return snapshot.hasData
                  ? ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((document) {
                        return InkWell(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FoodDetail(
                                          image: 'assets/astro.png',
                                          title: document['name'],
                                          price: document['price'],
                                        )))
                          },
                          child: FoodTile(
                              image: "assets/astro.png",
                              title: document['name'],
                              price: document['price']),
                        );
                      }).toList(),
                    )
                  : Text('problem');
            }),
      ),
    );
  }
}
