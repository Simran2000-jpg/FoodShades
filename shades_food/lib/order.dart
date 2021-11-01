import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
// import 'package:foodshades/confirm.dart';
import 'package:awesome_notifications/src/awesome_notifications_core.dart';
// import 'package:foodshades/notifications.dart';
// import 'foodshades/Confirmation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

// import 'feedback.dart';
import 'notifications.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

  CountDownController _controller = CountDownController();

  @override
  void dispose() {
    // TODO: implement dispose
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2C2C37),
        title: Text(
          'FoodShades',
          style: TextStyle(
              fontFamily: "Montserrat Bold",
              color: Color(0xFFE5E5E5),
              fontSize: 20),
        ),
        elevation: 1,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 30.0),
          ),
        ],
        centerTitle: false,
      ),
      //
      backgroundColor: Color(0xFF1E1E29),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 30, 10, 30),

                    child: Row(
                      children: [
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
                  CircularCountDownTimer(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 2,
                    duration: 14,
                    fillColor: Colors.amber,
                    ringColor: Colors.white,
                    controller: _controller,
                    backgroundColor: Colors.white54,
                    strokeWidth: 10.0,
                    strokeCap: StrokeCap.round,
                    isTimerTextShown: true,
                    isReverse: false,
                    onComplete: () {
                      createFoodNotifications();
                      Navigator.pop(context);
                    },
                    textStyle: TextStyle(fontSize: 50, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // body: SingleChildScrollView(
      //   child: CircularCountDownTimer(
      //     width: MediaQuery.of(context).size.width / 2,
      //     height: MediaQuery.of(context).size.height / 2,
      //     duration: 14,
      //     fillColor: Colors.amber,
      //     ringColor: Colors.white,
      //     controller: _controller,
      //     backgroundColor: Colors.white54,
      //     strokeWidth: 10.0,
      //     strokeCap: StrokeCap.round,
      //     isTimerTextShown: true,
      //     isReverse: false,
      //     onComplete: () {
      //       Navigator.push(context,
      //           MaterialPageRoute(builder: (context) => ConfirmPage()));
      //     },
      //     textStyle: TextStyle(fontSize: 50, color: Colors.black),
      //   ),
      // ),
    );
  }
}
