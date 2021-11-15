import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CurrentOrdersAdmin extends StatefulWidget {
  const CurrentOrdersAdmin({Key? key}) : super(key: key);

  @override
  _CurrentOrdersAdminState createState() => _CurrentOrdersAdminState();
}

class _CurrentOrdersAdminState extends State<CurrentOrdersAdmin> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance.collection('Dish').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    title: Text(document['name']),
                                    subtitle: Text(document['price']),
                                    leading: Container(
                                      child: Image(
                                        image:
                                            NetworkImage(document['imageurl']),
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
                                                title: Text("CONFIRM ORDER?"),
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      TextButton(
                                                          onPressed: () {},
                                                          child: Text('NO'),
                                                          style: TextButton
                                                              .styleFrom(
                                                            primary:
                                                                Colors.white,
                                                            backgroundColor:
                                                                Colors.red,
                                                          )),
                                                      TextButton(
                                                        onPressed: () {},
                                                        child: Text('YES'),
                                                        style: TextButton
                                                            .styleFrom(
                                                          primary: Colors.white,
                                                          backgroundColor:
                                                              Colors.green,
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
          )
        ]));
  }
}
