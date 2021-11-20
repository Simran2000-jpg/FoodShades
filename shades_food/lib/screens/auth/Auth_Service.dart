// import 'package:firebase_app_web/pages/HomePage.dart';
// ignore_for_file: prefer_function_declarations_over_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shades_food/screens/auth/PhoneVerifPage.dart';
import 'package:shades_food/screens/home/homescreen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
var user = FirebaseAuth.instance.currentUser;

class AuthClass {
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return PhoneVerifPage();
        }
      },
    );
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final storage = FlutterSecureStorage();
  String _phone = "";

  void storeTokenAndData(UserCredential userCredential) async {
    await storage.write(
        key: "token", value: userCredential.credential!.token.toString());
    await storage.write(
        key: "usercredential", value: userCredential.toString());
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context, Function setData) async {
    //
    _phone = phoneNumber;
    // ignore: prefer_function_declarations_over_variables
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) {};

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      showSnackBar(context, exception.toString());
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingtoken]) {
      showSnackBar(context, "Verification code sent on the phone number");
      setData(verificationId);
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      showSnackBar(context, "Time out");
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signInwithPhoneNumber(
      String verificationId, String smsCode, BuildContext context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      storeTokenAndData(userCredential);
      var user = FirebaseAuth.instance.currentUser;
      String _uid = user == null ? "" : user.uid;
      final DocumentSnapshot snap =
          await FirebaseFirestore.instance.collection('users').doc(_uid).get();

      if (!snap.exists) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(_uid)
            .set({'phone': _phone, 'name': "Anonymous", 'email': "unknown"});
      }
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => HomeScreen()),
          (route) => false);

      showSnackBar(context, "Logged in");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void showSnackBar(BuildContext context, String text) {
    // final snackBar = SnackBar(
    //   content: Text(text.toString()),
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print(text);
  }
}
