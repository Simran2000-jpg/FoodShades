import 'package:cloud_firestore/cloud_firestore.dart';
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
  Razorpay razorpay = Razorpay();
  TextEditingController textEditingController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
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
    var userid = "";
    Map<String, int> mp = {};
    for (var it in widget.cartid) {
      var v = await FirebaseFirestore.instance.collection("cart").doc(it).get();
      mp[v.get("dishid")] = v.get("count");
      userid = v.get("userid");
      FirebaseFirestore.instance.collection("cart").doc(it).delete();
    }
    FirebaseFirestore.instance.collection("CurrentOrders").add({
      "dishandcount": mp,
      "totalprice": widget.price,
      "userid": userid,
      "time": DateTime.now(),
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => OrderPage()));
    print("Payment Success");
  }

  void handlerPaymentError() {
    print("Payment Error");
  }

  void handlerExternalWallet() {
    print("External Wallet");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Razor Pay"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Your Total Amount is Rs${widget.price}',
                style: TextStyle(fontSize: 40.0),
              ),
              ElevatedButton(
                  onPressed: () {
                    openCheckout();
                  },
                  child: Text("PAY")),
            ]),
      ),
    );
  }
}
