import 'package:flutter/material.dart';
import 'package:plantdisese/ui/Detector.dart';
import 'package:plantdisese/ui/RegisterPage.dart';
import 'package:plantdisese/ui/SignInPage.dart';
import 'package:plantdisese/ui/detectornon.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
       
      body: SingleChildScrollView(
        child: Container(
           
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  "assets/pdback.png",
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height:30),
                             Row(children: <Widget>[
                                    
                                    SizedBox(width:220),
                                     FlatButton(
                              onPressed: () => {
                              Navigator.of(context).push(
                              MaterialPageRoute<void>(builder: (_) => Detectornon()),
                              )
                              },
                              padding: EdgeInsets.all(10.0),
                              child: Row( // Replace with a Row for horizontal icon + text
                                children: <Widget>[
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.pink,
                                    size: 25,
                                  ),
                                  SizedBox(width: 5,),
                                  Text("SKIP",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.pink,
                                          letterSpacing: 1))
                                ],
                              ),
                            ),








                             ],),




                            SizedBox(
                              height: 20,
                            ),
                            Text("Welcome!",
                                style: TextStyle(
                                    fontSize: 40,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1)),
                            SizedBox(
                              height: 5,
                            ),
                            Text("       Nice to See you!",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    letterSpacing: 1)),
                            SizedBox(
                              height: 50,
                            ),
                            Text("Plant Disease",
                                style: TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                    letterSpacing: 1)),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Text("Detector",
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pink,
                                      letterSpacing: 1)),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            GestureDetector(
                              onTap: () => _pushPage(context, SignInPage()),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.pink),
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.pink,
                                ),
                                child: Text("Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 25,
                                        letterSpacing: 1)),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 45),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("You are not a member?",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            )),
                        GestureDetector(
                          onTap: () => _pushPage(context, RegisterPage()),
                          child: Text(" Register",
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}
