import 'dart:async';

import 'package:flutter/material.dart';
import 'package:propusers/screens/sign_up_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFF316eb7),
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Image(
            fit: BoxFit.contain,
            image: AssetImage('assets/images/logo.png'),
          ),
        ),
      ),
    );
  }
}
