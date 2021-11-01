// import 'package:firebase_app_web/pages/HomePage.dart';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shades_food/splashscreen.dart';

Future registerUser(String mobile, BuildContext context) async {}

class AuthClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final storage = new FlutterSecureStorage();
  String _phone = "";

  // Future<void> googleSignIn(BuildContext context) async {
  //   try {
  //     GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  //     GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount.authentication;
  //     AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //     if (googleSignInAccount != null) {
  //       UserCredential userCredential =
  //           await _auth.signInWithCredential(credential);
  //       storeTokenAndData(userCredential);
  //       Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (builder) => HomePage()),
  //           (route) => false);

  //       final snackBar =
  //           SnackBar(content: Text(userCredential.user.displayName));
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     }
  //   } catch (e) {
  //     print("here---->");
  //     final snackBar = SnackBar(content: Text(e.toString()));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  // }

  // Future<void> signOut({BuildContext context}) async {
  //   try {
  //     await _googleSignIn.signOut();
  //     await _auth.signOut();
  //     await storage.delete(key: "token");
  //   } catch (e) {
  //     final snackBar = SnackBar(content: Text(e.toString()));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  // }

  void storeTokenAndData(UserCredential userCredential) async {
    print("storing token and data");
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
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) {
      showSnackBar(context, "Verification Completed");
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      showSnackBar(context, exception.toString());
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingtoken]) {
      showSnackBar(context, "Verification code sent on the phone number");
      setData(verificationId);
    };
    //     (String verificationID, [int forceResendingtoken]) {
    //   showSnackBar(context, "Verification Code sent on the phone number");
    //   setData(verificationID);
    // };

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
            .set({'uid': _uid, "phone": _phone, 'role': "user"});
      }
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => SplashScreen()),
          (route) => false);

      showSnackBar(context, "Logged in");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text.toString()));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
