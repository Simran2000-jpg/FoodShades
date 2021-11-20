import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shades_food/screens/customText.dart';
//import 'package:shades_food/screens/auth/SignInPage.dart';
import 'package:shades_food/splashscreen.dart';
import 'package:uuid/uuid.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  String _uid = "";
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _description = "", _name = "", _price = "", _time = "", _rating = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
    getUser();
    if (_uid == "") {
      print('No User');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SplashScreen()));
    }
    super.initState();
  }

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
                    onPressed: () => selectImage(context),
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

    await FirebaseFirestore.instance.collection("Dish").add({
      'name': _name,
      'price': _price,
      'userid': _uid,
      'imageurl': mediaUrl,
      'description': _description,
      'time': _time,
      'rating': _rating,
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
        child: Text('Submit'),
        onPressed: isUploading ? null : () => handleSubmit(),
      ),
      body: ListView(
        children: [
          isUploading ? LinearProgressIndicator() : Text(""),
          Container(
            height: 220,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(_image!),
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
              Icons.people,
              color: Colors.orange,
              size: 35.0,
            ),
            title: Container(
              width: 250,
              child: TextField(
                onChanged: (value) {
                  _name = value;
                },
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
              Icons.money,
              color: Colors.orange,
              size: 35.0,
            ),
            title: Container(
              width: 250,
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _price = value;
                },
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
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (value) {
                  _description = value;
                },
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
              Icons.timelapse,
              color: Colors.orange,
              size: 35.0,
            ),
            title: Container(
              width: 250,
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  NumericalRangeFormatter(min: 0.00, max: 2.60),
                  LengthLimitingTextInputFormatter(4),
                ],
                onChanged: (value) {
                  _time = value;
                },
                decoration: InputDecoration(
                  hintText: "Time (in hr)",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.rate_review_outlined,
              color: Colors.orange,
              size: 35.0,
            ),
            title: Container(
              width: 250,
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  NumericalRangeFormatter(min: 0.0, max: 5.0),
                  LengthLimitingTextInputFormatter(3),
                ],
                onChanged: (value) {
                  _rating = value;
                },
                decoration: InputDecoration(
                  hintText: "Rating (0.0-5.0)",
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

  @override
  Widget build(BuildContext context) {
    return _image == null ? buildSplashScreen() : buildUploadForm();
  }
}
