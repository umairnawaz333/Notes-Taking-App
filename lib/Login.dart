import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_notes_taking_app/Registration.dart';
import 'package:my_notes_taking_app/main.dart';

void main() => runApp(MaterialApp(home: SignInScreen()));

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String email,password,username;

  void signIn() async{
    BuildContext dialogContext;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        dialogContext = context;
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: new Row(
              children: [
                new CircularProgressIndicator(),
                SizedBox(width: 25.0,),
                new Text("Loading"),
              ],
            ),
          ),
        );
      },
    );

    UserCredential result;
    try{
      await Firebase.initializeApp();
      result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    }
    catch(error){
      Fluttertoast.showToast(
          msg: error.code,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0
      );
    }

    Navigator.of(dialogContext).pop();
    User user = result.user;
    if (user != null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyApp()
      ), (Route<dynamic> route) => false);

    }
    else{
      Fluttertoast.showToast(
          msg: "user not found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(187, 220, 38, 0.8),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          body: ListView(
            children: <Widget>[
              Container(
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain, image: AssetImage('images/2.png'))),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    IconButton(icon: Icon(Icons.email), onPressed: null),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(right: 20, left: 10),
                            child: TextField(

                              onChanged: (value){
                              email = value;
                            },
                              decoration: InputDecoration(hintText: 'Email')

                            )))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.lock), onPressed: null),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(right: 20, left: 10),
                            child: TextField(
                              obscureText: true,
                              onChanged: (value){
                                password = value;
                              },
                              decoration: InputDecoration(hintText: 'Password',
                                  ),
                            ))),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 50,
                    width: 150,
                    child: RaisedButton(
                      onPressed: () {
                        signIn();
                      },
                      color: Colors.lightGreen,
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(builder:
                      (BuildContext context) => SignUpScreen()));
                },
                child: Center(
                  child: RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: '  SIGN UP ',
                            style: TextStyle(
                                color: Colors.deepOrange, fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
      ),
    );
  }
}
