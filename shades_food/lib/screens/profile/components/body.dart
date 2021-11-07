import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shades_food/screens/auth/SignUpPage.dart';
import 'package:shades_food/screens/home/drawerstatus.dart';
import 'package:shades_food/splashscreen.dart';

import 'profile_menu.dart';

class Body extends StatelessWidget {
  Body({required this.status});
  final statusCallback status;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '',
                  style: const TextStyle(fontSize: 18),
                ),
                GestureDetector(
                    onTap: () {
                      status(false);
                    },
                    child: const Icon(Icons.close))
              ],
            ),
          ),
          // ProfilePic(),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icon/User.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icon/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icon/Log out.svg",
            press: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SplashScreen()));
            },
          ),
        ],
      ),
    );
  }
}
