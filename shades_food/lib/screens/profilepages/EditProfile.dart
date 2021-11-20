import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  final String currentUserId;
  EditProfile(this.currentUserId);
  // const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String uId = "", nameg = "", phoneg = "", emailg = "";
  String profImagePath = "";
  dynamic _imageUrl = null;
  bool isLoading = false;

  late User user;

  late TextEditingController _emailController;
  late TextEditingController _usernameController;
  bool _isEditingText = false;
  bool _isEditingUser = false;

  getUserId() {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      uId = auth.currentUser!.uid;
    }
  }

  Future getUserInfo() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        nameg = snapshot['name'];
        emailg = snapshot['email'];
        phoneg = snapshot['phone'];
      });
    });
  }

  Future updateInfo() async {
    FirebaseFirestore.instance.collection('users').doc(uId).update({
      'name': _usernameController.text.toString(),
      'email': _emailController.text.toString(),
    });
  }

  @override
  void initState() {
    getUserId();
    getUserInfo();
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController(text: emailg);
    _usernameController = TextEditingController(text: nameg);
    var ref =
        FirebaseStorage.instance.ref().child('users/' + uId + '/profile.png');
    ref
        .getDownloadURL()
        .then((loc) => setState(() => _imageUrl = loc))
        .catchError((err) => {_imageUrl = null});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFE699),
      appBar: AppBar(
        backgroundColor: Color(0xffFFF1AF),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.orange,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: TextStyle(
              fontFamily: "Montserrat Bold",
              color: Colors.orange,
              fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.orange,
            ),
            onPressed: () {
              updateInfo();
              if (profImagePath != "")
                uploadProfilePicture(
                    profImagePath); //saves and updates the changes in dashboard..
              Toast.show("Changes Saved", context,
                  duration: Toast.LENGTH_SHORT);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
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
                        fit: BoxFit.cover,
                        // image: NetworkImage(
                        //     'https://googleflutter.com/sample_image.jpg'),
                        image: _imageUrl == null
                            ? NetworkImage(
                                'https://firebasestorage.googleapis.com/v0/b/karvaan-app-15704.appspot.com/o/users%2Fdownload%20(1).png?alt=media&token=4337d9ee-45dd-4993-a794-ca4a70d7b911')
                            : NetworkImage(_imageUrl),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Colors.orange,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () async {
                        // File image = await ImagePicker.pickImage(
                        //     source: ImageSource.gallery);
                        final _picker = ImagePicker();
                        PickedFile? image =
                            await _picker.getImage(source: ImageSource.gallery);
                        print(image!.path);
                        setState(() {
                          profImagePath = image.path.toString(); //Image Picker
                        });
                        ;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 230,
              child: Card(
                color: Color(0xffFFF1AF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: _editUserNameField(),
                    ),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        color: Color(0xffB2EA70),
                        padding: EdgeInsets.only(left: 18, top: 4, right: 7),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'Phone',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Montserrat Medium",
                                      color: Color(0xFFC85C5C)),
                                ),
                                Text(
                                  phoneg,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Montserrat Medium",
                                      color: Colors.black),
                                )
                              ],
                            ),
                            IconButton(
                              padding: EdgeInsets.only(
                                  left: 130, top: 4, right: 2, bottom: 2),
                              icon: Icon(
                                Icons.https,
                                color: Color(0xFF1E1E29),
                              ),
                              onPressed: () {},
                            ),
                          ], //Can't edit the phone number
                        ),
                      ),
                      onTap: () async {
                        Toast.show("Can't Edit", context,
                            duration: Toast.LENGTH_SHORT);
                      },
                    ),

                    //Let's Edit email......
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        padding: EdgeInsets.only(left: 1, top: 4, right: 10),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      45.0, 10.0, 10.0, 0.0),
                                  child: Text(
                                    'Email',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Montserrat Medium",
                                        color: Color(0xFFC85C5C)),
                                  ),
                                ),
                              ],
                            ),
                            _editEmailTextField(),
                          ],
                        ),
                      ),
                      onTap: () async {},
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                'Tap on the fields to edit them',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    fontFamily: "Montserrat Medium",
                    color: Color(0xFFC85C5C)),
              ),
            )
          ],
        ),
      ),
    );
    // void showToast(String msg, {int duration, int gravity}) {
    //   Toast.show(msg, context, duration: duration, gravity: gravity);
    // }
  }

  uploadProfilePicture(String imagePath) async {
    //uploading profile picture,specifying path
    File file = File(imagePath);
    try {
      await FirebaseStorage.instance
          .ref()
          .child('users/' + uId + '/profile.png')
          .putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  //
  Widget _editEmailTextField() {
    //specifically for email edit.....
    if (_isEditingText)
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: TextField(
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat Regular',
            ),
            onSubmitted: (newValue) {
              setState(() {
                emailg = newValue;
                _isEditingText = false;
              });
            },
            autofocus: true,
            controller: _emailController,
          ),
        ),
      );
    return InkWell(
      onTap: () {
        setState(() {
          _isEditingText = true;
        });
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 17),
            child: Text(
              _isEditingText ? _emailController.text : emailg,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontFamily: "Montserrat Medium"),
            ),
          ),
        ],
      ),
    );
  }

  //

  Widget _editUserNameField() {
    //specifically for Username edit.....
    if (_isEditingUser)
      return Center(
        child: TextField(
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat Regular',
          ),
          onSubmitted: (newValue) {
            setState(() {
              nameg = newValue;
              _isEditingUser = false;
            });
          },
          autofocus: true,
          controller: _usernameController,
        ),
      );
    return InkWell(
      onTap: () {
        setState(() {
          _isEditingUser = true;
        });
      },
      child: Text(
        _isEditingUser ? _usernameController.text : nameg,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 28.0,
          fontFamily: "Montserrat SemiBold",
          color: Colors.black,
        ),
      ),
    );
  }
}
