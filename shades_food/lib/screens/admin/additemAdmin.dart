import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddItemAdmin extends StatefulWidget {
  const AddItemAdmin({Key? key}) : super(key: key);

  @override
  _AddItemAdminState createState() => _AddItemAdminState();
}

class _AddItemAdminState extends State<AddItemAdmin> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _name = "";
  String _price = "";
  void addData() async {
    try {
      await _firestore.collection("Dish").add({
        'name': _name,
        "price": _price,
      });
      ;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text('ADD ITEM TO MENU'),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
                autofocus: true,
                decoration: new InputDecoration(
                  hintText: 'Name: ',
                ),
              ),
              TextField(
                autofocus: true,
                onChanged: (value) {
                  setState(() {
                    _price = value;
                  });
                },
                decoration: new InputDecoration(
                  hintText: 'Price: ',
                ),
              ),
              TextButton(
                  onPressed: () {
                    addData();
                  },
                  child: Text('ADD'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange))),
            ],
          ),
        ),
      ),
    );
  }
}
