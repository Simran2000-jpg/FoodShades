import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shades_food/screens/auth/SignUpPage.dart';
import 'package:toast/toast.dart';

final int user = 0;

class OTPpage extends StatefulWidget {
  final phoneNumber;

  // const OTPpage(String s, {Key? key, this.phoneNumber}) : super(key: key);
  const OTPpage(this.phoneNumber);

  @override
  _OTPpageState createState() => _OTPpageState(phoneNumber);
}

class _OTPpageState extends State<OTPpage> {
  // FirebaseAuth _auth = FirebaseAuth.instance;

  // String? inputData() {
  //   final User? user = _auth.currentUser;
  //   final uid = user?.uid;

  //   return uid;

  //   // here you write the codes to input the data into firestore
  // }

  String phoneNumber;
  _OTPpageState(this.phoneNumber);

  late String verificationId, smsCode;
  bool codeSent = false;

  @override
  void initState() {
    // TODO: implement initState
    verifyPhone(phoneNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFC495),
        iconTheme: IconThemeData(
          color: Color(0xFF1E1E29),
        ),
        elevation: 0,
      ),
      backgroundColor: Color(0xFFFFC495),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
              child: Text(
                "Please wait for the OTP sent to your number.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Montserrat SemiBold',
                  color: Color(0xFF1E1E29),
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(35, 20, 100, 0),
              child: OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 30,
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF454551),
                    fontFamily: 'Montserrat Medium'),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onChanged: (pin) {
                  setState(() {
                    this.smsCode = pin;
                  });
                },
              ),
            ),

            //child 3: Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
                  child: Text(
                    "Didn't Receive the OTP?",
                    style: TextStyle(
                        fontFamily: 'Montserrat Medium',
                        fontSize: 14,
                        color: Color(0xFF454551D1)),
                  ),
                ),

                //Child resend otp...

                Container(
                  margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                  child: new GestureDetector(
                    onTap: () {
                      Toast.show("Resending...", context,
                          duration: Toast.LENGTH_SHORT);
                      verifyPhone(phoneNumber);
                    },
                    child: Text('Resend OTP',
                        style: TextStyle(
                            fontFamily: 'Montserrat Medium',
                            fontSize: 16,
                            color: Color(0xFFFFF7C6))),
                  ),
                )
              ],
            ),

            //verifying the user

            Container(
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: Color(0xFF1E1E29),
                ),
                margin: EdgeInsets.fromLTRB(25, 200, 25, 20),
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      Text(
                        "Verify",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Montserrat SemiBold',
                            fontSize: 16,
                            color: Color(0xFFE5E5E5)),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward,
                        color: Color(0xFFFFF7C6),
                      )
                    ],
                  ),
                  onPressed: () {
                    print(codeSent);
                    if (codeSent) {
                      //
                      //

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}

Future<void> verifyPhone(phoneNumber) async {
  final PhoneVerificationCompleted verified = (AuthCredential authResult) {
    // AuthService().signIn(authResult);
  };

  final PhoneVerificationFailed
      verificationfailed = //method, if verification fails
      (FirebaseAuthException authException) {
    print('${authException.message}');
  };

  // final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
  //     //method, sending sms code
  //     this.verificationId = verId;
  //     setState(() {
  //       this.codeSent = true;
  //     });
  //   };

//   final PhoneCodeAutoRetrievalTimeout autoTimeOut = (String verId) {
//     this.verificationId = verId;
//   };

//   await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       timeout: const Duration(seconds: 60),
//       verificationCompleted: verified,
//       verificationFailed: verificationfailed,
//       codeSent: smsSent,
//       codeAutoRetrievalTimeout: autoTimeOut);
}
