import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Admin_OrderList extends StatefulWidget {
  const Admin_OrderList({Key? key}) : super(key: key);

  @override
  _Admin_OrderListState createState() => _Admin_OrderListState();
}

class _Admin_OrderListState extends State<Admin_OrderList> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    children: snapshot.data!.docs.map((document) {
                      return Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 20,
                                  bottom: 5,
                                ),
                                child: Text(
                                  "Name of Dish: " + document['name'],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 20,
                                  bottom: 5,
                                ),
                                child: Text(
                                  "Price of Dish: " + document['price'],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  )
                : Text('problem');
          }),
    );
  }
}
