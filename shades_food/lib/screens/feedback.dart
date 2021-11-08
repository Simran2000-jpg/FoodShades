import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({Key? key}) : super(key: key);

  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  var myFeedback = "Could be better";
  var slider = 0.0;
  IconData myFeedbackdata = FontAwesomeIcons.sadTear;
  Color myfeedbackcolor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
          title: Text("Feedback"),
          actions: <Widget>[
            IconButton(icon: Icon(FontAwesomeIcons.solidStar), onPressed: () {})
          ],
        ),
        body: Container(
          color: Color(0xffE5E5E5),
          child: Column(
            children: <Widget>[
              Container(
                  child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        child: Text(
                          "1.On a scale of 1 to 5, how do you rate our food item",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ))),
              SizedBox(
                height: 25,
              ),
              Container(
                  child: Align(
                child: Material(
                  color: Colors.white,
                  elevation: 14.0,
                  borderRadius: BorderRadius.circular(24),
                  shadowColor: Colors.grey,
                  child: Container(
                    width: 350,
                    height: 400,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            child: Text(
                              myFeedback,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            child: Icon(
                              myFeedbackdata,
                              color: myfeedbackcolor,
                              size: 100,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            child: Slider(
                              min: 0.0,
                              max: 5.0,
                              divisions: 5,
                              value: slider,
                              activeColor: Color(0xffff520d),
                              inactiveColor: Colors.blueGrey,
                              onChanged: (newValue) {
                                setState(() {
                                  slider = newValue;
                                  if (slider >= 0.0 && slider <= 1.0) {
                                    myFeedbackdata = FontAwesomeIcons.sadTear;
                                    myfeedbackcolor = Colors.red;
                                    myFeedback = "Could Be Better";
                                  }
                                  if (slider >= 1.0 && slider <= 2.0) {
                                    myFeedbackdata = FontAwesomeIcons.frown;
                                    myfeedbackcolor = Colors.yellow;
                                    myFeedback = "Below Average";
                                  }
                                  if (slider >= 2.0 && slider <= 3.0) {
                                    myFeedbackdata = FontAwesomeIcons.sadTear;
                                    myfeedbackcolor = Colors.amber;
                                    myFeedback = "Normal";
                                  }
                                  if (slider >= 3.0 && slider <= 4.0) {
                                    myFeedbackdata = FontAwesomeIcons.smile;
                                    myfeedbackcolor = Colors.green;
                                    myFeedback = "Good";
                                  }
                                  if (slider >= 4.0 && slider <= 5.0) {
                                    myFeedbackdata = FontAwesomeIcons.laugh;
                                    myfeedbackcolor = Color(0xffff520d);
                                    myFeedback = "Brilliant";
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                              child: Text(
                            "Your Rating: $slider",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  color: Colors.yellow,
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(color: Color(0xffffffff)),
                                  ),
                                  onPressed: () {},
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
            ],
          ),
        ));
  }
}
