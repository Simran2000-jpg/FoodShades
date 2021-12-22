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
      var dish = await FirebaseFirestore.instance
          .collection('Dish')
          .doc(v.get("dishid"))
          .get();
      int t = int.parse(dish.get('time'));
      int c = await v.get('count');
      totaltime += t * c;
      mp.add({"name": dish.id, "count": v.get("count").toString()});
      userid = v.get("userid");
      customer = await FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .get();
      FirebaseFirestore.instance.collection("cart").doc(it).delete();
    }
    for (var it in mp) {
      FirebaseFirestore.instance.collection("CurrentOrders").add({
        "dishandcount": [it],
        "customer_name": customer.get('name'),
        "customer_phnno": customer.get('phone'),
        "time": DateTime.now(),
        "orderno": count,
        "userid": userid,
        "totaltime": totaltime,
        "totalprice": widget.price,
      });
    }
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
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Razor Pay"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Your Total Amount is Rs ${widget.price}',
                style: TextStyle(fontSize: 25.0),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .3,
              ),
              ElevatedButton(
                  onPressed: () {
                    openCheckout();
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.orange),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 15),
                    child: Text("PAY"),
                  )),
            ]),
      ),
    );
  }
}
