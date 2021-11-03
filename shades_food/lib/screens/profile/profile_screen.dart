import 'package:flutter/material.dart';
import 'package:shades_food/screens/home/drawerstatus.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  // static String routeName = "/profile";
  const ProfileScreen({required this.status});
  final statusCallback status;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        status: status,
      ),
    );
  }
}
