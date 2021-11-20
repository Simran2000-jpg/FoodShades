import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as PATH;

import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';
import 'package:shades_food/screens/admin/upload_image.dart';
//import 'package:shades_food/screens/auth/SignInPage.dart';
import 'package:shades_food/splashscreen.dart';
import 'package:uuid/uuid.dart';

class EditAdminScreen extends StatefulWidget {
  String imageurl = "",
      name = "",
      price = "",
      time = "",
      description = "",
      dishid = "";
  EditAdminScreen(
      {Key? key,
      required this.name,
      required this.price,
      required this.time,
      required this.description,
      required this.imageurl,
      required this.dishid})
      : super(key: key);

  @override
  _EditAdminScreenState createState() => _EditAdminScreenState();
}

class _EditAdminScreenState extends State<EditAdminScreen> {
  String _uid = "";
  FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController time = TextEditingController();
  String imageurl = "";
  String dishid = "";
  getUser() {
    //getting user id from database, cloud firestore
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      _uid = auth.currentUser!.uid;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    name.text = widget.name;
    price.text = widget.price;
    description.text = widget.description;
    imageurl = widget.imageurl;
    time.text = widget.time;
    dishid = widget.dishid;
    getUser();
    photochanged = false;
    // if (_uid == "") {
    //   print('No User');
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => SplashScreen()));
    // }
    super.initState();
  }

  bool openuploadsplash = false;
  var storageRef = FirebaseStorage.instance.ref();
  File? _image;
  final picker = ImagePicker();
  bool isUploading = false;
  String postId = Uuid().v4();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        openuploadsplash = false;
        photochanged = true;
      } else {
        print('No image selected.');
      }
    });
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text("Create Post"),
            children: <Widget>[
              SimpleDialogOption(
                child: Text("Select image from gallery"),
                onPressed: () {
                  getImage();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  bool photochanged = false;
  Container buildSplashScreen() {
    return Container(
      color: Colors.blueAccent,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/dosa.jpg'), fit: BoxFit.cover),
            ),
          ),
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 400.0,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Text(
                      "Upload Image",
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                    color: Colors.deepPurple,
                    onPressed: () {
                      selectImage(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  clearImage() {
    setState(() {
      _image = null;
    });
  }

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image? imagefile = Im.decodeImage(_image!.readAsBytesSync());
    final File? compressedImageFile = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imagefile!, quality: 85));
    setState(() {
      _image = compressedImageFile;
    });
  }

  Future<String> uploadImage(imageFile) async {
    String url = "";
    UploadTask uploadTask = storageRef
        .child("Images")
        .child(_uid)
        .child("post_$postId.jpg")
        .putFile(imageFile);
    await uploadTask.whenComplete(() async {
      url = await uploadTask.snapshot.ref.getDownloadURL();
    });

    return url;
  }

  handleSubmit() async {
    setState(() {
      isUploading = true;
    });
    await compressImage();
    String mediaUrl = await uploadImage(_image);
    //add data to firebase'

    await FirebaseFirestore.instance.collection("Dish").doc(dishid).set({
      'name': name.text,
      'price': price.text,
      'userid': _uid,
      'imageurl': mediaUrl,
      'description': description.text,
      'time': time.text,
    });

    Navigator.pop(context);
  }

  Scaffold buildUploadForm() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        // ignore: missing_required_param
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: clearImage,
        ),
        title: Text(
          "Description",
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
        ),
        child: Text('UPDATE'),
        onPressed: isUploading ? null : () => handleSubmit(),
      ),
      body: ListView(
        children: [
          isUploading ? LinearProgressIndicator() : Text(""),
          GestureDetector(
            onTap: () {
              changePhoto();
            },
            child: Container(
              height: 220,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: photochanged
                      ? Container(
                          decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover, image: FileImage(_image!)),
                        ))
                      : Container(
                          decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(imageurl)),
                        )),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          ListTile(
            leading: Icon(
              Icons.description,
              color: Colors.orange,
              size: 35.0,
            ),
            title: Container(
              width: 250,
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "Name",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.description,
              color: Colors.orange,
              size: 35.0,
            ),
            title: Container(
              width: 250,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: price,
                decoration: InputDecoration(
                  hintText: "Price",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.description,
              color: Colors.orange,
              size: 35.0,
            ),
            title: Container(
              width: 250,
              child: TextField(
                controller: description,
                decoration: InputDecoration(
                  hintText: "Write Description ....",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.description,
              color: Colors.orange,
              size: 35.0,
            ),
            title: Container(
              width: 250,
              child: TextField(
                controller: time,
                decoration: InputDecoration(
                  hintText: "Time",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  void changePhoto() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text("Select An Option"),
              children: <Widget>[
                TextButton(
                    onPressed: () {
                      setState(() {
                        openuploadsplash = true;
                      });
                      Navigator.of(context, rootNavigator: true).pop('dialog');

                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         EditAdminScreen()));
                    },
                    child: Text('SELECT PHOTO'),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                    )),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return openuploadsplash ? buildSplashScreen() : buildUploadForm();
  }
}
