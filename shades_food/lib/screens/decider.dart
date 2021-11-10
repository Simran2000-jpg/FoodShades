import 'package:flutter/material.dart';
import 'package:shades_food/screens/admin/adminscreen.dart';
import 'package:shades_food/splashscreen.dart';

class DeciderPage extends StatefulWidget {
  const DeciderPage({Key? key}) : super(key: key);

  @override
  _DeciderPageState createState() => _DeciderPageState();
}

class _DeciderPageState extends State<DeciderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Decide'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(25),
              child: TextButton(
                child: Text(
                  'Admin',
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => AdminScreen()),
                      (route) => false);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: TextButton(
                child: Text(
                  'User',
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => SplashScreen()),
                      (route) => false);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
