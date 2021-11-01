import 'package:flutter/material.dart';

// import 'package:page_transition/page_transition.dart';
// import 'package:pizaato/AdminPanel/Views/LoginPage.dart';
// import 'package:pizaato/views/Login.dart';
void main() {
  runApp(Decider());
}

class Decider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.2, 0.45, 0.6, 0.9],
                colors: [
                  Color(0xff200B4B),
                  Color(0xff201F22),
                  Color(0xff1A1031),
                  Color(0xff19181F),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.85,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/astro.png'),
              ),
            ),
          ),
          Positioned(
            top: 500.0,
            left: 20.0,
            child: Container(
              height: 200,
              width: 200,
              child: RichText(
                text: TextSpan(
                    text: 'Select ',
                    style: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 46.0),
                    children: [
                      TextSpan(
                        text: 'Your ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0),
                      ),
                      TextSpan(
                        text: 'Side',
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0),
                      ),
                    ]),
              ),
            ),
          ),
          Positioned(
            top: 620,
            child: Container(
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0)),
                      color: Colors.red[400],
                      child: Text(
                        'Customer',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     PageTransition(
                        //         child: Login(),
                        //         type: PageTransitionType.rightToLeft));
                      }),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0)),
                      color: Colors.redAccent,
                      child: Text(
                        'Employee',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     PageTransition(
                        //         child: AdminLogin(),
                        //         type: PageTransitionType.rightToLeft));
                      }),
                ],
              ),
            ),
          ),
          Positioned(
            top: 720.0,
            left: 20.0,
            right: 20.0,
            child: Container(
              width: 400.0,
              constraints: BoxConstraints(maxHeight: 200),
              child: Column(
                children: [
                  Text(
                    "By continuing you agree Pizzato's Terms of",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                  Text(
                    "Services & Privacy Policy",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
