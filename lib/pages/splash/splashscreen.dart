import 'dart:async';

import 'package:event_booking/shared_preferences/jwt_auth_token.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // this is function which checks if the user is logged in or not and if the user is logged in then it will redirect to the homepage of the user
  Widget? myWidget;
  bool? isAuth;

  checkSharedPref() async {
    Future.delayed(const Duration(seconds: 3), () async {
      final token = await Authcontroller.getAuthToken();

      try {
        if (token != null) {
          _navigateTo(true);
        } else {
          _navigateTo(false);
        }
      } catch (e) {
        debugPrint(e.toString());
        setState(() {
          myWidget = const SplashScreen();
        });
      }
    });
  }

  _navigateTo(bool isAuth) {
    if (isAuth) {
      Navigator.pushNamed(context, '/navigation');
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  void initState() {
    super.initState();
    checkSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(168, 60, 3, 74),
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 160,
          ),
          Image.asset(
            "assets/images/splashscreen.png",
            height: 450.0,
            width: 350.0,
          ),
          const SizedBox(
            height: 70,
          ),
        ],
      )),
    );
  }
}
