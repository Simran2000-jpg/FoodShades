import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shades_food/screens/home/homescreen.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({Key? key}) : super(key: key);

  @override
  _FeedBackScreenState createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 15, vertical: 10),
                //       child: GestureDetector(
                //         onTap: () => {
                //           Navigator.pop(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => HomeScreen())),
                //         },
                //         child: Card(
                //             shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(20)),
                //             elevation: 10,
                //             color: Colors.white,
                //             child: const Padding(
                //               padding: EdgeInsets.all(5.0),
                //               child: Icon(
                //                 Icons.arrow_back,
                //                 size: 30,
                //                 color: Colors.orange,
                //               ),
                //             )),
                //       ),
                //     ),
                //   ],
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "FEEDBACKS",
                    style: TextStyle(
                        color: Colors.orange,
                        fontFamily: 'Montserrat',
                        fontSize: 30),
                  ),
                ),
                Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Stack(children: [
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('FeedBack')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("Loading");
                            }
                            return snapshot.hasData
                                ? ListView(
                                    shrinkWrap: true,
                                    children:
                                        snapshot.data!.docs.map((document) {
                                      return OrderItem(document);
                                    }).toList(),
                                  )
                                : Text('problem');
                          }),
                    ]),
                  ),
                )
              ])),
    );
  }

  Widget OrderItem(QueryDocumentSnapshot document) {
    String customer_name = document['customer_name'];
    String comment = document['comment'];
    int orderno = document['orderno'];
    double rating = document['rating'];
    return Card(
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OrderNo. ${orderno}',
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  Text('Customer: $customer_name'),
                  Text('Rating $rating / 5.0'),
                  Text('Comment: $comment'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
