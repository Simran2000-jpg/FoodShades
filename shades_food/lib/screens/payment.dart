import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shades_food/screens/cart/cart_screen.dart';

import '../order.dart';

// ignore: must_be_immutable

class Payment extends StatefulWidget {
  int price = 0;
  List<String> cartid = <String>[];

  Payment({
    Key? key,
    required this.price,
    required this.cartid,
  }) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int totaltime = 0;
  Razorpay razorpay = Razorpay();
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
    razorpay.on(Razorpay.PAYMENT_CANCELLED.toString(), handlerCancelPayment);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_xmnLBhmX7WPCYC",
      "amount": widget.price * 100,
      "name": "Food Shades",
      "description": "Payment for the some random product",
      "prefill": {
        "contact": "8081360868",
        "email": "srijansaxena679@gmail.com"
      },
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) async {
    //When payment is successfully completed
    String userid = "";
    var c = await FirebaseFirestore.instance
        .collection('OrderNo')
        .doc('OrderCount')
        .get();
    int count = c.get('current');
    await FirebaseFirestore.instance
        .collection('OrderNo')
        .doc('OrderCount')
        .set({'current': count + 1});
    var customer;
    List<Map<String, String>> mp = [];
    for (var it in widget.cartid) {
      var v = await FirebaseFirestore.instance.collection("cart").doc(it).get();
      var dishid = await v.get('dishid');
      var dish =
          await FirebaseFirestore.instance.collection('Dish').doc(dishid).get();
      int t = int.parse(dish.get('time'));
      int c = await v.get('count');
      totaltime += t * c;
      mp.add({"name": dish.get('name'), "count": v.get("count").toString()});
      userid = v.get("userid");
      customer = await FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .get();
      FirebaseFirestore.instance.collection("cart").doc(it).delete();
    }
    FirebaseFirestore.instance
        .collection("CurrentOrders")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "dishandcount": mp,
      "totalprice": widget.price,
      "customer_name": customer.get('name'),
      "customer_phnno": customer.get('phone'),
      "totaltime": totaltime,
      "time": DateTime.now(),
      "orderno": count,
      "userid": userid,
    });

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => OrderPage(
                  totaltime: totaltime,
                )));
    print("Payment Success");
  }

  void handlerPaymentError() {
    print("Payment Error");
  }

  void handlerExternalWallet() {
    print("External Wallet");
  }

  void handlerCancelPayment() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 230.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 10.0),
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: AssetImage('assets/images/money.jpg'),
                        ),
                      ),
                    ),
                    Text(
                      'Your Total Amount is To Pay is:',
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                    Text(
                      'Rs ${widget.price}',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 100.0,
                      height: 50.0,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          onPressed: () {
                            openCheckout();
                          },
                          child: Text("PAY")),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
