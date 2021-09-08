import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vastu_machine_test/home/home_page.dart';
import 'package:vastu_machine_test/utility/utils.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorUtils.color_app_bar,
        child: Center(
          child: Text("Vaastu Check",style: TextStyle(
            color: Colors.white,
            fontSize: 40.0,
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }

  void startTimer() {
    Timer(Duration(seconds: 3), () {
     Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: 
                    (context)=>HomePageScreen())
                  );
    });
  }

 
}