import 'dart:async';

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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
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
                        ? Column(
                            children: snapshot.data!.docs.map((document) {
                              return OrderItem(document);
                            }).toList(),
                          )
                        : Text('problem');
                  }),
            )
          ])),
    );
  }

  Widget OrderItem(QueryDocumentSnapshot document) {
    var totalprice = document['totalprice'];
    String customer_name = document['customer_name'];
    String customer_phone = document['customer_phnno'];
    Map<int, String> month = {
      1: 'Jan',
      2: 'Feb',
      3: 'Mar',
      4: 'Apr',
      5: 'May',
      6: 'Jun',
      7: 'Jul',
      8: 'Aug',
      9: 'Sep',
      10: 'Oct',
      11: 'Nov',
      12: 'Dec'
    };

    Timestamp ts = document['time'];
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(ts.seconds * 1000);
    ts.compareTo(Timestamp.now());
    int orderno = document['orderno'];
    return Card(
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'OderNo. ${orderno}',
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                  Text(
                      'Time Of Order: ${dt.day} ${month[dt.month]} ${dt.hour}hr ${dt.minute}min'),
                  Text('Total Price: Rs ${totalprice}'),
                  Text('Customer Name: ${customer_name}'),
                  Text('Customer Phn Number: Rs ${customer_phone}'),
                  listOfItems(document),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listOfItems(QueryDocumentSnapshot document) {
    List<dynamic> mp = document['dishandcount'];
    return ExpansionTile(
      title: Text('List of Items Ordered'),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('ITEM'),
            Text('COUNT'),
          ],
        ),
        Divider(height: 1),
        ListView.separated(
          shrinkWrap: true,
          itemCount: mp.length,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 10);
          },
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(mp[index]['name']),
                SizedBox(width: 20),
                Text(mp[index]['count']),
              ],
            );
          },
        )
      ],
    );
  }
}
