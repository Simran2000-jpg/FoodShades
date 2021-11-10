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
                        return Column(
                          children: [
                            ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              title: Text(document['name']),
                              subtitle: Text(document['price']),
                              leading: Container(
                                child: Image(
                                  image: NetworkImage(document['imageurl']),
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              onTap: () {
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        SimpleDialog(
                                          title: Text("Select An Option"),
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                TextButton(
                                                    onPressed: () {},
                                                    child: Text('EDIT'),
                                                    style: TextButton.styleFrom(
                                                      primary: Colors.white,
                                                      backgroundColor:
                                                          Colors.blue,
                                                    )),
                                                TextButton(
                                                  onPressed: () {
                                                    deleteitem(document.id);
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop();
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
                            ),
                            Divider(),
                          ],
                        );
                      }).toList(),
                    )
                  : Text('problem');
            }),
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

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text.toString()));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
