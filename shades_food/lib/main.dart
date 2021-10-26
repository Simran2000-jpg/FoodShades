// @dart=2.9
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shades_food/screens/auth/PhoneVerifPage.dart';
import 'package:shades_food/screens/auth/SignUpPage.dart';
import 'package:shades_food/splashscreen.dart';
import 'package:provider/provider.dart';
import 'order.dart';

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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [
        Locale('en', "US"), //suported language set to US English
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        //test for git
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
    // return MultiProvider(
    //   providers: [
    //     Provider<AuthService>(
    //       create: (_) => AuthService(FirebaseAuth.instance),
    //     ),
    //     StreamProvider(
    //       create: (context) => context.read<AuthService>().authStateChanges,
    //     ),
    //   ],
    //   child: MaterialApp(
    //     title: "APP",
    //     home: AuthWrapper(),
    //   ),
    // );
  }
}
