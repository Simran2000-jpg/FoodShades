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
          Container(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('CurrentOrders')
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
                      ? ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((document) {
                            return OrderItem(document);
                          }).toList(),
                        )
                      : Text('problem');
                }),
          )
        ]));
  }

  Widget OrderItem(QueryDocumentSnapshot document) {
    return Card(
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('Total Price: Rs${document['totalprice']}')],
            ),
          ),
        ],
      ),
    );
  }
}
