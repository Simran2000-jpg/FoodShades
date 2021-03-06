// @dart=2.9
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shades_food/order.dart';
import 'package:shades_food/screens/admin/additemAdmin.dart';
import 'package:shades_food/screens/admin/adminscreen.dart';
import 'package:shades_food/screens/confirmPage.dart';
import 'package:shades_food/screens/home/homescreen.dart';
import 'package:shades_food/screens/payment.dart';
import 'package:shades_food/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'key1',
      channelName: 'FoodShades',
      channelDescription: 'Time up!',
      defaultColor: Colors.blue,
      ledColor: Colors.white,
      playSound: true,
      enableLights: true,
      enableVibration: true,
    )
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale('en', "US"), //suported language set to US English
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
