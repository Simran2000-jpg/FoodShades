import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shades_food/screens/contact.dart';
import 'package:shades_food/screens/home/homescreen.dart';

class ConfirmPage extends StatefulWidget {
  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  var _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Rating Dialog In Flutter'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 200.0),
          child: Column(
            children: [
              Center(
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.cyan,
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Text(
                    'Received your order?',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onPressed: _showRatingAppDialog,
                ),
              ),
              Center(
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.cyan,
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Text(
                    'Did not receive your food item(s) ?',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (builder) => ContactPage()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double roundOffToXDecimal(double number, {int numberOfDecimal = 1}) {
    // To prevent number that ends with 5 not round up correctly in Dart (eg: 2.275 round off to 2.27 instead of 2.28)
    String numbersAfterDecimal = number.toString().split('.')[1];
    if (numbersAfterDecimal != '0') {
      int existingNumberOfDecimal = numbersAfterDecimal.length;
      number += 1 / (10 * pow(10, existingNumberOfDecimal));
    }

    return double.parse(number.toStringAsFixed(numberOfDecimal));
  }

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      // ratingColor: Colors.amber,
      title: Text(
        'Rate this app and tell others what you think.',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),

      image: Image.asset(
        "assets/saute.png",
        height: 200,
      ),
      submitButtonText: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) async {
        var customer_id = _auth.currentUser!.uid;
        var customer = await FirebaseFirestore.instance
            .collection('users')
            .doc(customer_id)
            .get();
        print('rating: ${response.rating}, '
            'comment: ${response.comment}');
        var num = await FirebaseFirestore.instance
            .collection('OrderNo')
            .doc('OrderCount')
            .get();
        await FirebaseFirestore.instance.collection('FeedBack').add({
          'rating': response.rating,
          'comment': response.comment,
          'customer_id': _auth.currentUser!.uid,
          'orderno': num.get('current') - 1,
          'customer_name': customer.get('name'),
        });
        var r = await FirebaseFirestore.instance
            .collection('Rating')
            .doc('CurrentRating')
            .get();
        double rating = r.get('rating');
        rating = (rating * 5 + response.rating) / 6;
        var rrating = roundOffToXDecimal(rating);
        rating.truncateToDouble();
        await FirebaseFirestore.instance
            .collection('Rating')
            .doc('CurrentRating')
            .set({'rating': rrating});
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
        // if (response.rating < 3.0) {
        //   print('response.rating: ${response.rating}');
        // } else {
        //   Container();
        // }
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );
  }
}
