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
        backgroundColor: const Color(0xFFFFC495),
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
                    width: size,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/astro.png'),
                      fit: BoxFit.fill,
                    )),
                  );
                },
              ),
              const SizedBox(
                height: 3,
              ),
              Shimmer.fromColors(
                baseColor: Color(0xFF1E1E29),
                highlightColor: Color(0xFFFFF7C6),
                child: const Text(
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
