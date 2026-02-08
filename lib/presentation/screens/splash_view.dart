import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // 3-second timer before navigating to Login
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color kBackgroundColor = Color(0xFF121212);
    const Color kPrimaryRed = Color(0xFFEC7E94); // Speed Spares Red

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Icon
            Icon(
              Icons.directions_car_filled,
              size: 100,
              color: kPrimaryRed,
            ),
            const SizedBox(height: 20),
            // App Title
            Text(
              'SPEED SPARES',
              style: GoogleFonts.racingSansOne(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            Text(
              'Repuestos Premium',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 60),
            // Loading Indicator
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kPrimaryRed),
            ),
          ],
        ),
      ),
    );
  }
}
