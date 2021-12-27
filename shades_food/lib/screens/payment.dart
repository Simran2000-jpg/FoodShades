import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shades_food/screens/cart/cart_screen.dart';

import '../order.dart';

// ignore: must_be_immutable
class Payment extends StatefulWidget {
  int price = 0;
  List<String> cartid = <String>[];
  List<DocumentSnapshot> datas = <DocumentSnapshot>[];
  List<int> cnt = <int>[];

  Payment({
    Key? key,
    required this.price,
    required this.cartid,
    required this.datas,
    required this.cnt,
  }) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int totaltime = 0;
  int count = 0;
  bool isLoading = false;
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
    setState(() {
      isLoading = true;
    });
    String userid = "";
    var c = await FirebaseFirestore.instance
        .collection('OrderNo')
        .doc('OrderCount')
        .get();
    count = c.get('current');
    await FirebaseFirestore.instance
        .collection('OrderNo')
        .doc('OrderCount')
        .set({'current': count + 1});
    var customer;
    List<Map<String, String>> mp = [];
    var v;
    for (var it in widget.cartid) {
      v = await FirebaseFirestore.instance.collection("cart").doc(it).get();
      var dish = await FirebaseFirestore.instance
          .collection('Dish')
          .doc(v.get("dishid"))
          .get();
      int t = int.parse(dish.get('time'));
      int c = await v.get('count');
      totaltime += t * c;
      mp.add({"name": dish.id, "count": v.get("count").toString()});

      FirebaseFirestore.instance.collection("cart").doc(it).delete();
    }
    userid = v.get("userid");
    customer =
        await FirebaseFirestore.instance.collection('users').doc(userid).get();
    await FirebaseFirestore.instance.collection("CurrentOrders").add({
      "dishandcount": mp,
      "customer_name": customer.get('name'),
      "customer_phnno": customer.get('phone'),
      "time": DateTime.now(),
      "orderno": count,
      "userid": userid,
      "totaltime": totaltime,
      "totalprice": widget.price,
      "asktr": false,
      "isreceived": false,
    });
    // FirebaseFirestore.instance.collection('UserAndOrderId').add(data)
    String order_id = "";
    QuerySnapshot data =
        await FirebaseFirestore.instance.collection('CurrentOrders').get();
    for (var item in data.docs) {
      if (item['orderno'] == count) order_id = item.id;
    }

    print('//////////////////////////////// $order_id');
    await FirebaseFirestore.instance
        .collection('userAndorder')
        .doc(userid)
        .set({'orderid': order_id});
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

  void handlerCancelPayment() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading == false)
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orange,
              title: Text("Payment"),
            ),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Colors.orange,
              label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  "Pay",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              onPressed: () {
                openCheckout();
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: Padding(
                padding: EdgeInsets.all(30.0),
                child: Expanded(
                  child: ListView.builder(
                    itemCount: widget.datas.length + 1,
                    itemBuilder: (context, index) {
                      // counter = fcnt[index];
                      return index < widget.datas.length
                          ? Container(
                              // color: Colors.amber,
                              // margin: EdgeInsets.only(
                              //     top: MediaQuery.of(context).size.height * 0.03,
                              //     left: MediaQuery.of(context).size.width * 0.03,
                              //     right: MediaQuery.of(context).size.width * 0.03,
                              //     bottom: MediaQuery.of(context).size.height * 0.01),
                              child: Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  // decoration: BoxDecoration(
                                  // color: Colors.white,
                                  // borderRadius: BorderRadius.circular(15),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.grey.withOpacity(0.5),
                                  //     spreadRadius: 5,
                                  //     blurRadius: 7,
                                  //     offset: Offset(0, 3), // changes position of shadow
                                  //   ),
                                  // ],
                                  // ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.datas[index]["name"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 1),
                                        child: Text(
                                          '\u{20B9}${widget.datas[index]["price"]} x ${widget.cnt[index].toString()}',
                                          // textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: Colors.orange),
                                        ),
                                      ),
                                    ],
                                  )),
                            )
                          : Column(
                              children: [
                                Divider(
                                  color: Colors.grey,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Total Price",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 15,
                                          )),
                                      Text(
                                        '\u{20B9}${widget.price}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Colors.orange),
                                      )
                                    ])
                              ],
                            );
                    },
                  ),
                )),
          )
        : Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
  }
}
