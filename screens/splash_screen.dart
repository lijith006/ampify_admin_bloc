import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../authentication/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //navigateToNextScreen();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 80,
              child: SpinKitWave(
                color: Color.fromARGB(255, 67, 25, 165),
                size: 33.0,
              ),
              //Image.asset('assets/images/ampify_logo.png')
            ),
            Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'Ampify - admin',
                    textStyle: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                totalRepeatCount: 1,
                repeatForever: false,
              ),
            )
            // Text(
            //   'Ampify-Admin',
            //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            // ),
          ],
        ),
      ),
    );
  }
}
