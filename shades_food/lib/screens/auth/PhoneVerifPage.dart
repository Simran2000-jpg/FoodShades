import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:shades_food/appcolors.dart';
import 'package:shades_food/screens/auth/Auth_Service.dart';
import 'package:sms_autofill/sms_autofill.dart';

class PhoneVerifPage extends StatefulWidget {
  const PhoneVerifPage({Key? key}) : super(key: key);

  @override
  _PhoneVerifPageState createState() => _PhoneVerifPageState();
}

class _PhoneVerifPageState extends State<PhoneVerifPage> {
  int start = 60;
  bool wait = false;
  String buttonName = "Send";
  bool codesent = false;

  TextEditingController phoneController = TextEditingController();
  AuthClass authClass = AuthClass();

  String verificationIdFinal = "";
  String smsCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffFF5151),

      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   title: Text(
      //     "SignUp",
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontSize: 24,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bgsp.jpg"), fit: BoxFit.cover)),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Padding(
                    // padding: const EdgeInsets.only(top: 30.0),
                    // Image.asset(
                    //   "assets/foodorder.png",
                    //   width: MediaQuery.of(context).size.width,
                    // ),
                    // ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 110,
              // ),
              textField(),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 30,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                    Text(
                      "Enter 6 digit OTP",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              otpField(),

              SizedBox(
                height: 40,
              ),
              RichText(
                  text: TextSpan(
                children: [
                  TextSpan(
                    text: "Send OTP again in ",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  TextSpan(
                    text: "00:$start",
                    style: TextStyle(fontSize: 16, color: Color(0xffFBFF00)),
                  ),
                  TextSpan(
                    text: " sec",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              )),

              SizedBox(
                height: 80,
              ),
              //
              InkWell(
                onTap: () {
                  authClass.signInwithPhoneNumber(
                      verificationIdFinal, smsCode, context);
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 60,
                  decoration: BoxDecoration(
                      color: AppColors.sk1,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(fontSize: 17, color: Colors.black),
                          // fontWeight: FontWeight.w700),
                        ),
                      ),
                      Center(
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);

    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget aot() {
    return PinFieldAutoFill(
      codeLength: 6,
      onCodeChanged: (val) {
        print('AutoFillField: ' + val!);
      },
    );
  }

  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: 1000,
      fieldWidth: 40,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: AppColors.sk1,
        borderColor: Colors.white,
      ),
      style: TextStyle(fontSize: 17, color: Colors.black),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          smsCode = pin;
        });
      },
      onChanged: (pin) {},
    );
  }

  Widget textField() {
    return Container(
      width: 330,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.sk1,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: phoneController,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter your phone number",
          hintStyle: TextStyle(color: Colors.black, fontSize: 17),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            child: Text(
              " (+91) ",
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
          ),

          //

          suffixIcon: InkWell(
            onTap: wait
                ? null
                : () async {
                    startTimer();
                    setState(() {
                      start = 60;
                      wait = true;
                      buttonName = "Resend";
                    });
                    await authClass.verifyPhoneNumber(
                        "+91 ${phoneController.text}", context, setData);
                  },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Text(
                buttonName,
                style: TextStyle(
                    color: wait ? Colors.grey : Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setData(verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });

    startTimer();
  }
}
