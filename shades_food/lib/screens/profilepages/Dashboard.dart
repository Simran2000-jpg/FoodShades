// // import 'package:flutter/material.dart';
// // import 'dart:io';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/rendering.dart';
// // import 'package:flutter/widgets.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:shades_food/appcolors.dart';
// // import 'package:shades_food/screens/profilepages/EditProfile.dart';
// // // import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// // import 'package:toast/toast.dart';

// // class ProfilePage extends StatefulWidget {
// //   const ProfilePage({Key? key}) : super(key: key);

// //   @override
// //   _ProfilePageState createState() => _ProfilePageState();
// // }

// // class _ProfilePageState extends State<ProfilePage> {
// //   String uId = "", name = "Error!", phone = 'Error!', email = "Error!";
// //   String _imageUrl = "null";
// //   bool isSwitched = false;

// //   getUserId() {
// //     FirebaseAuth auth = FirebaseAuth.instance;
// //     if (auth.currentUser != null) uId = auth.currentUser!.uid;
// //   }

// //   Future getUserInfo() async {
// //     FirebaseFirestore.instance
// //         .collection('users')
// //         .doc(uId)
// //         .snapshots()
// //         .listen((snapshot) {
// //       setState(() {
// //         name = "";
// //         email = "";
// //         phone = snapshot['phone'];
// //       });
// //     });
// //   }

// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     // super.initState();
// //     getUserId();
// //     getUserInfo();
// //     super.initState();

// //     // await ref

// //     // var ref =
// //     //     FirebaseStorage.instance.ref().child('users/' + uId + '/profile.png');
// //     // ref.getDownloadURL().then((loc) => setState(() => _imageUrl = loc));
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: AppColors.dark1,
// //         iconTheme: IconThemeData(
// //           color: AppColors.sk2,
// //         ),
// //         centerTitle: true,
// //         title: Text(
// //           "DASHBOARD",
// //           style: TextStyle(
// //               fontFamily: "Montserrat Bold",
// //               color: Color(0xFFE5E5E5),
// //               fontSize: 16),
// //         ),
// //         elevation: 1,
// //         actions: [
// //           Padding(
// //             padding: EdgeInsets.only(right: 20.0),
// //           ),
// //         ],
// //       ),
// //       backgroundColor: Color(0xff1E1E29),
// //       body: SingleChildScrollView(
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.stretch,
// //           children: [
// //             Center(
// //                 child: Column(children: [
// //               Container(
// //                 margin: EdgeInsets.all(30),
// //                 width: 160,
// //                 height: 160,
// //                 decoration: BoxDecoration(
// //                   border: Border.all(
// //                       width: 4,
// //                       color: Theme.of(context).scaffoldBackgroundColor),
// //                   boxShadow: [
// //                     BoxShadow(
// //                         spreadRadius: 2,
// //                         blurRadius: 10,
// //                         color: Colors.black.withOpacity(0.1),
// //                         offset: Offset(0, 10))
// //                   ],
// //                   shape: BoxShape.circle,
// //                   image: DecorationImage(
// //                       image: _imageUrl == "null"
// //                           ? NetworkImage(
// //                               'https://firebasestorage.googleapis.com/v0/b/foodshades-c3c18.appspot.com/o/users%2Fprofile.png?alt=media&token=71a672ad-a16d-4a49-bb32-1b1ca78ec16f')
// //                           : NetworkImage(_imageUrl!),
// //                       fit: BoxFit.fill),
// //                 ),
// //               ),
// //             ])),
// //             Container(
// //               height: 380,
// //               width: 250,
// //               color: Color(0xff1E1E29),
// //               padding: const EdgeInsets.all(10.0),
// //               child: Card(
// //                 color: Color(0xff2C2C37),
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(30),
// //                 ),
// //                 child: Column(
// //                   children: [
// //                     ListTile(
// //                       title: Text(
// //                         name,
// //                         textAlign: TextAlign.center,
// //                         style: TextStyle(
// //                             fontSize: 30,
// //                             fontFamily: "Montserrat Bold",
// //                             color: AppColors.sk4),
// //                       ),
// //                     ),
// //                     Row(
// //                       children: [
// //                         Padding(
// //                             padding: EdgeInsets.fromLTRB(30.0, 20.0, 10.0, 0.0),
// //                             child: Text('Phone',
// //                                 style: TextStyle(
// //                                     fontSize: 16,
// //                                     fontFamily: "Montserrat Medium",
// //                                     color: AppColors.sk3)))
// //                       ],
// //                     ),
// //                     Row(
// //                       children: [
// //                         Padding(
// //                             padding: EdgeInsets.fromLTRB(20.0, 5.0, 10.0, 5.0),
// //                             child: Text(
// //                               phone,
// //                               style: TextStyle(
// //                                   fontSize: 19,
// //                                   fontFamily: "Montserrat Medium",
// //                                   color: Color(0xffe5e5e5)),
// //                             )),
// //                       ],
// //                     ),
// //                     Row(
// //                       children: [
// //                         Padding(
// //                           padding: EdgeInsets.fromLTRB(30.0, 30.0, 10.0, 0.0),
// //                           child: Text(
// //                             'Email',
// //                             style: TextStyle(
// //                                 fontSize: 16,
// //                                 fontFamily: "Montserrat Medium",
// //                                 color: AppColors.sk4),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     Row(
// //                       children: [
// //                         Padding(
// //                           padding: EdgeInsets.fromLTRB(20.0, 5.0, 10.0, 5.0),
// //                           child: Text(
// //                             email,
// //                             style: TextStyle(
// //                                 fontSize: 19,
// //                                 fontFamily: "Montserrat Medium",
// //                                 color: Color(0xffe5e5e5)),
// //                           ),
// //                         )
// //                       ],
// //                     ),
// //                     Row(mainAxisAlignment: MainAxisAlignment.end, children: [
// //                       Padding(
// //                         padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
// //                         child: FloatingActionButton(
// //                           heroTag: "btn1",
// //                           backgroundColor: AppColors.sk3,
// //                           onPressed: () {
// //                             // return Navigator.push(
// //                             //     context,
// //                             //     MaterialPageRoute(
// //                             //         builder: (context) => EditProfile(uId)));
// //                           },
// //                           child: Icon(
// //                             Icons.edit,
// //                             size: 30,
// //                           ),
// //                         ),
// //                       ),
// //                     ]),
// //                   ],
// //                 ),
// //               ),
// //             ),

// //             //Divider in between two cards....
// //             Container(
// //               margin: EdgeInsets.only(left: 90, top: 1, right: 90, bottom: 0),
// //               child: Divider(
// //                 color: AppColors.sk4,
// //                 height: 15.0,
// //                 indent: 5.0,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shades_food/screens/profilepages/EditProfile.dart';
import 'package:toast/toast.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String uId,
      name = "Error!",
      phone = 'Error!',
      email = "Error!"; //defined default values for the fields.
  late String _imageUrl;
  TextEditingController _newBikeNameController =
      new TextEditingController(); //controller for bike name
  TextEditingController _newBikeRentController =
      new TextEditingController(); //controller for bike rent
  TextEditingController
      _newBikeLocationController = //controller for bike location
      new TextEditingController();
  bool isSwitched = false; //default value for switch

  getUserId() {
    //getting UserId from firestore collection...
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      uId = auth.currentUser!.uid;
    }
  }

  Future getUserInfo() async {
    //Extracting user info from firestore...
    //to get user information
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        name = snapshot["name"];
        email = snapshot["email"];
        phone = snapshot["phoneNo"];
      });
    });
  }

  @override
  void initState() {
    //initState...
    getUserId();
    getUserInfo();
    super.initState();
    var ref =
        FirebaseStorage.instance.ref().child('users/' + uId + '/profile.png');
    ref.getDownloadURL().then((loc) =>
        setState(() => _imageUrl = loc)); //setting path for profile image
  }

  @override
  Widget build(BuildContext context) {
    //Here starts the UI of the overall Dashboard Screen....
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF2C2C37),
          iconTheme: IconThemeData(
            color: Color(0xFFFFC495),
          ),
          centerTitle: true,
          title: Text(
            "DASHBOARD",
            style: TextStyle(
                fontFamily: "Montserrat Bold",
                color: Color(0xFFE5E5E5),
                fontSize: 16),
          ),
          elevation: 1,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
            ),
          ],
        ),
        backgroundColor: Color(0xFF1E1E29),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
                child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.all(30),
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 4,
                      color: Theme.of(context).scaffoldBackgroundColor),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(0, 10))
                  ],
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      // image: NetworkImage(
                      //     'https://googleflutter.com/sample_image.jpg'),
                      image: _imageUrl == null
                          ? NetworkImage(
                              'https://firebasestorage.googleapis.com/v0/b/karvaan-app-15704.appspot.com/o/users%2Fdownload%20(1).png?alt=media&token=4337d9ee-45dd-4993-a794-ca4a70d7b911')
                          : NetworkImage(_imageUrl),
                      fit: BoxFit.fill),
                ),
              ),
            ])),

            Container(
              height: 380,
              width: 250,
              color: Color(0xFF1E1E29),
              padding: const EdgeInsets.all(10.0),
              child: Card(
                color: Color(0xFF2C2C37),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: "Montserrat Bold",
                            color: Color(0xFFFFC495)),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(30.0, 20.0, 10.0, 0.0),
                            child: Text(
                              'Phone',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Montserrat Medium",
                                  color: Color(0xFFCA9367)),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 5.0, 10.0, 5.0),
                            child: Text(
                              phone,
                              style: TextStyle(
                                  fontSize: 19,
                                  fontFamily: "Montserrat Medium",
                                  color: Color(0xFFE5E5E5)),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(30.0, 30.0, 10.0, 0.0),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Montserrat Medium",
                                  color: Color(0xFFCA9367)),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 5.0, 10.0, 5.0),
                            child: Text(
                              email,
                              style: TextStyle(
                                  fontSize: 19,
                                  fontFamily: "Montserrat Medium",
                                  color: Color(0xFFE5E5E5)),
                            )),
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                        child: FloatingActionButton(
                          heroTag: "btn1",
                          backgroundColor: Color(0xFFCA9367),
                          onPressed: () {
                            // return Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => EditProfile(uId)));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile(uId)));
                          },
                          child: Icon(
                            Icons.edit,
                            size: 30,
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),

            //Divider in between two cards....
            Container(
              margin: EdgeInsets.only(left: 90, top: 1, right: 90, bottom: 0),
              child: Divider(
                // thickness: 1,
                color: Color(0xFFFFC495),
                height: 15.0,
                indent: 5.0,
              ),
            ),
          ],
        )));
  }
}
