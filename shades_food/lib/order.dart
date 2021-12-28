import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:foodshades/confirm.dart';
import 'package:awesome_notifications/src/awesome_notifications_core.dart';
import 'package:qr_flutter/qr_flutter.dart';
// import 'package:foodshades/notifications.dart';
// import 'foodshades/Confirmation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shades_food/screens/confirmPage.dart';
import 'package:shades_food/screens/feedbacks/feedback.dart';

// import 'feedback.dart';
import 'notifications.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  CountDownController _controller = CountDownController();
  int totaltime = 0;
  String orderid = "";
  String orderno = "";

  bool asktr = false;
  bool isreceived = false;
  var orderdata;
  bool hasOrderd = false;
  void getData() async {
    String user_id = FirebaseAuth.instance.currentUser!.uid;
    var data = await FirebaseFirestore.instance
        .collection('userAndorder')
        .doc(user_id)
        .get();
    if (data.exists) {
      orderid = data.get('orderid');
      orderdata = await FirebaseFirestore.instance
          .collection('CurrentOrders')
          .doc(orderid)
          .get();
      setState(() {
        orderno = orderdata.get('orderno').toString();
        hasOrderd = true;
        totaltime = orderdata.get('totaltime') * 60;
      });
    }
  }

  void initializedata() async {}

  @override
  void initState() {
    // TODO: implement initState
    totaltime = 10;
    super.initState();
    getData();
    initializedata();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Allow Notifications'),
                  content: Text('Allow our app to send notifications'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Don\'t Allow',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () => AwesomeNotifications()
                            .requestPermissionToSendNotifications()
                            .then((_) => Navigator.pop(context)),
                        child: Text(
                          'Allow',
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                ));
      }
    });

    // AwesomeNotifications().createdStream.listen((event) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text(
    //       'Notification created on ${notification.channelKey}',
    //     ),
    //   ));
    // });

    AwesomeNotifications().actionStream.listen((notification) {
      //
      if (notification.channelKey == 'basic_channel' && Platform.isIOS) {
        AwesomeNotifications().getGlobalBadgeCounter().then(
              (value) => AwesomeNotifications().getGlobalBadgeCounter(),
            );
      }
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(
      //       // builder: (_) => FbPage(),
      //     ),
      //     (route) => route.isFirst);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (orderid != "") {
      FirebaseFirestore.instance
          .collection('CurrentOrders')
          .doc(orderid)
          .snapshots()
          .listen((DocumentSnapshot documentSnapshot) {
        bool asktr1 = documentSnapshot.get('asktr');
        bool isreceived1 = documentSnapshot.get('isreceived');
        asktr = asktr1;
        isreceived = isreceived1;
        if (isreceived) {
          FirebaseFirestore.instance
              .collection('userAndorder')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .delete();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => ConfirmPage()));
        }
        if (asktr) {
          createFoodNotifications();
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => SimpleDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Text("Please Come To Pick Your Order"),
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ));
        }
      });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text(
            'FoodShades',
            style: TextStyle(
                fontFamily: "Montserrat Bold",
                color: Color(0xFFE5E5E5),
                fontSize: 20),
          ),
          elevation: 1,
          actions: const <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 30.0),
            ),
          ],
          centerTitle: false,
        ),
        //

        body: hasOrderd
            ? Ordered()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black, spreadRadius: 3),
                        ],
                      ),
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.2),
                      // alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Image.asset(
                        "assets/images/emptyorder.jpg",
                        fit: BoxFit.fill,
                      ))
                ],
              ));
  }

  Widget Ordered() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.green, spreadRadius: 3),
                      ],
                    ),
                    child: Text(
                      'Order no: ${orderno}',
                      style: TextStyle(fontSize: 30.0, color: Colors.green),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 10, 10, 10),

                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(30),
                          child: Text(
                            "Food is being prepared ...",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22,

                                // fontFamily:
                                color: Colors.amber),
                          ),
                        ),
                      ],
                    ),

                    // child: Text(
                    //   CrossAxisAlignment.s
                    //   "Wohoo! Something Delicious Creeping in...",
                    //   style: TextStyle(
                    //       fontSize: 20,
                    //       // fontFamily:
                    //       color: Colors.amber),
                    // ),
                  ),
                  Container(
                    child: CircularCountDownTimer(
                      duration: totaltime,
                      isReverseAnimation: true,
                      isReverse: true,
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 2,
                      fillColor: Colors.amber,
                      ringColor: Colors.white,
                      controller: _controller,
                      backgroundColor: Colors.white54,
                      strokeWidth: 10.0,
                      strokeCap: StrokeCap.round,
                      isTimerTextShown: true,
                      onComplete: () async {
                        setState(() {
                          isreceived = true;
                        });
                      },
                      textStyle: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Your Generated QR Code:',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    QrImage(
                      data: orderid,
                      version: QrVersions.auto,
                      size: 250,
                      gapless: false,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
