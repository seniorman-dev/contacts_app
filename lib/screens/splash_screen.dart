import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:contact_app/screens/home_screen.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Image.asset('asset/images/logo.png',),   //color: Colors.black,
      ), 
      nextScreen: HomeScreen(), 
      duration: 2000, //4000
      backgroundColor: Colors.white, 
      centered: true,
      splashIconSize: 700,  //200,
      //splashTransition: SplashTransition.scaleTransition,
      animationDuration: Duration(seconds: 2),  //2
    );
  }
}