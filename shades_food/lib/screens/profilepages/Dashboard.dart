import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shades_food/screens/profilepages/EditProfile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String uId = "",
      name = "",
      phone = "",
      email = ""; //defined default values for the fields.
  dynamic _imageUrl = null;

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
        name = snapshot['name'];
        email = snapshot['email'];
        phone = snapshot["phone"];
      });
    });
  }

  @override
  void initState() {
    //initState...
    getUserId();
    getUserInfo();
    super.initState();

//     const storageFile = bucket.file('path/to/file.txt');
// storageFile
//   .exists()
//   .then((exists) => {
//     if (exists[0]) {
//       console.log("File exists");
//     } else {
//       console.log("File does not exist");
//   })

    var ref =
        FirebaseStorage.instance.ref().child('users/' + uId + '/profile.png');
    ref
        .getDownloadURL()
        .then((loc) => setState(() => _imageUrl = loc))
        .catchError(
            (err) => {_imageUrl = null}); //setting path for profile image
  }

  @override
  Widget build(BuildContext context) {
    //Here starts the UI of the overall Dashboard Screen....
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffFFF1AF),
          iconTheme: IconThemeData(
            color: Colors.orange,
          ),
          centerTitle: true,
          title: Text(
            "DASHBOARD",
            style: TextStyle(
                fontFamily: "Montserrat Bold",
                color: Colors.orange,
                fontSize: 16),
          ),
          elevation: 1,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
            ),
          ],
        ),
        backgroundColor: Color(0xffFFE699),
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
                  border: Border.all(width: 4, color: Color(0xffFFF1AF)),
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
              height: 340,
              width: 250,
              color: Color(0xffFFE699),
              padding: const EdgeInsets.all(10.0),
              child: Card(
                color: Color(0xffFFF1AF),
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
                            fontFamily: "Montserrat SemiBold",
                            color: Colors.black),
                      ),
                    ),
                    //name
                    // Row(
                    //   children: [
                    //     Padding(
                    //         padding: EdgeInsets.fromLTRB(30.0, 0.0, 10.0, 0.0),
                    //         child: Text(
                    //           'Email',
                    //           style: TextStyle(
                    //               fontSize: 16,
                    //               fontFamily: "Montserrat Medium",
                    //               color: Color(0xFFCA9367)),
                    //         )),
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     Padding(
                    //         padding: EdgeInsets.fromLTRB(20.0, 5.0, 10.0, 5.0),
                    //         child: Text(
                    //           name,
                    //           style: TextStyle(
                    //               fontSize: 19,
                    //               fontFamily: "Montserrat Medium",
                    //               color: Color(0xFFE5E5E5)),
                    //         )),
                    //   ],
                    // ),
                    //
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(30.0, 20.0, 10.0, 0.0),
                            child: Text(
                              'Phone',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Montserrat Medium",
                                  color: Color(0xFFC85C5C)),
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
                                  color: Colors.black),
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
                                  color: Color(0xFFC85C5C)),
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
                                  color: Colors.black),
                            )),
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                        child: FloatingActionButton(
                          heroTag: "btn1",
                          backgroundColor: Colors.orange,
                          onPressed: () {
                            // return Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => EditProfile(uId)));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile(uId)));
                            // getUserInfo();
                          },
                          child: Icon(
                            Icons.edit,
                            size: 30,
                            color: Colors.white,
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
