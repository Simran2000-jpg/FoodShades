import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shades_food/screens/contact.dart';

class ConfirmPage extends StatefulWidget {
  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
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
      onSubmitted: (response) {
        print('rating: ${response.rating}, '
            'comment: ${response.comment}');

        if (response.rating < 3.0) {
          print('response.rating: ${response.rating}');
        } else {
          Container();
        }
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );
  }
}
