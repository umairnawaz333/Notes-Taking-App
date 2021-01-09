import 'package:flutter/material.dart';
import 'dart:async';

import 'package:my_notes_taking_app/Login.dart';
import 'package:my_notes_taking_app/Welcome/components/background.dart';

void main() => runApp(MaterialApp(home: WelcomeScreen()));

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer();
  }

  void timer() async{
        Timer(Duration(seconds: 4), (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => SignInScreen(),
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome to Notes Taking App",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23.0),
              ),
              SizedBox(height: size.height * 0.15),
              Image.asset(
                "images/2.png",
                height: size.height * 0.45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
