import 'package:flutter/material.dart';
import 'package:shades_food/screens/auth/Auth_Service.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Tween<double> _sizeTween = Tween<double>(begin: 20, end: 150);
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => AuthClass().handleAuth()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color(0xffFFF9B6),
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/bg3.jpg"),
        fit: BoxFit.cover,
      )),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder(
            tween: _sizeTween,
            duration: Duration(milliseconds: 1000),
            builder: (_, size, __) {
              return Container(
                height: size as double,
                width: size,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/restaurant.png'),
                  fit: BoxFit.fill,
                )),
              );
            },
          ),
          const SizedBox(
            height: 3,
          ),
          Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.white,
            child: const Text(
              "FOODSHADES",
              style: TextStyle(
                fontFamily: 'Montserrat Bold',
                color: Colors.white,
                fontSize: 40,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
