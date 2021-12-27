import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shades_food/screens/admin/editAdminScreen.dart';

import '../../splashscreen.dart';
import 'additemAdmin.dart';

class Admin_DishList extends StatefulWidget {
  const Admin_DishList({Key? key}) : super(key: key);

  @override
  _Admin_DishListState createState() => _Admin_DishListState();
}

class _Admin_DishListState extends State<Admin_DishList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "LIST OF DISHES",
                  style: TextStyle(
                      color: Colors.orange,
                      fontFamily: 'Montserrat Bold',
                      fontSize: 30),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    alignment: Alignment.center,
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.orange)),
                onPressed: () {
                  print("ADD ITEM PRESSED_____________________");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Upload()));
                },
                child: Text('ADD ITEM'),
              ),
              Container(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Dish')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }
                      return snapshot.hasData
                          ? Column(
                              children: snapshot.data!.docs.map((document) {
                                return DishCard(document);
                              }).toList(),
                            )
                          : Text('problem');
                    }),
              )
            ])),
      ),
    );
  }

  Widget DishCard(QueryDocumentSnapshot document) {
    return Card(
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        onTap: () {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => SimpleDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Text("Select An Option"),
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TextButton(
                              onPressed: () {
                                print('edit pressed');
                                Navigator.pop(context);
                                editItem(document);
                              },
                              child: Text('EDIT'),
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.blue,
                              )),
                          TextButton(
                            onPressed: () {
                              deleteitem(document.id);
                              Navigator.pop(context);
                            },
                            child: Text('DELETE'),
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ink.image(
              image: NetworkImage(document['imageurl']),
              height: 240,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name : ${document['name']}'),
                  Text('Price : Rs. ${document['price']}'),
                  Text('Time To Prepare : ${document['time']} min')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deleteitem(String id) async {
    try {
      await FirebaseFirestore.instance.collection('Dish').doc(id).delete();
      setState(() {
        showSnackBar(context, 'Item Deleted Successfully');
      });
    } catch (e) {
      print(e);
    }
  }

  void editItem(QueryDocumentSnapshot document) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditAdminScreen(
              name: document['name'],
              price: document['price'],
              time: document['price'],
              description: document['description'],
              imageurl: document['imageurl'],
              dishid: document.id,
            )));
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text.toString()));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
