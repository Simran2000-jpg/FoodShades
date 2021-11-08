import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

// ignore: must_be_immutable
class Payment extends StatefulWidget {
  int price;
  Payment({
    Key? key,
    required this.price,
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
      "amount": num.parse(textEditingController.text) * 100,
      "name": "Sample App",
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

  void handlerPaymentSuccess() {
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
        child: Column(children: <Widget>[
          TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: "Enter Amount",
            ),
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
