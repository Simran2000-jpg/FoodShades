import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddItemAdmin extends StatefulWidget {
  const AddItemAdmin({Key? key}) : super(key: key);

  @override
  _AddItemAdminState createState() => _AddItemAdminState();
}

class _AddItemAdminState extends State<AddItemAdmin> {
  String _name = "", _price = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
