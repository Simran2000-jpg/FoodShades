import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserOrderList extends StatefulWidget {
  const UserOrderList({Key? key}) : super(key: key);

  @override
  _UserOrderListState createState() => _UserOrderListState();
}

class _UserOrderListState extends State<UserOrderList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        SimpleDialog(
                                          title: Text("Select An Option"),
                                          children: <Widget>[
                                            SimpleDialogOption()
                                          ],
                                        ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.blueAccent)),
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
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  : Text('problem');
            }),
      ),
    );
  }
}
