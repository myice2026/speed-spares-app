import 'package:flutter/material.dart';
import 'dart:async';
import 'login_view.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2C2C),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/LOGO_SPEED_SPARES_(3)[1].jpg',
              width: 300,
              height: 300,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.red),
          ],
        ),
      ),
    );
  }
}
