import 'package:flutter/material.dart';
import 'package:shades_food/screens/auth/Auth_Service.dart';
// import 'package:karvaan/screens/services/authentication.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Tween<double> _sizeTween = Tween<double>(begin: 20, end: 150);
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => AuthClass().handleAuth()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFC495),
        body: Container(
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
                    width: size as double,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/astro.png'),
                      fit: BoxFit.fill,
                    )),
                  );
                },
              ),
              SizedBox(
                height: 3,
              ),
              Shimmer.fromColors(
                baseColor: Color(0xFF1E1E29),
                highlightColor: Color(0xFFFFF7C6),
                child: Text(
                  "FOODSHADES",
                  style: TextStyle(
                    fontFamily: 'Montserrat Bold',
                    color: Color(0xFF1E1E29),
                    fontSize: 18,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
