import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantdisese/main.dart';
import 'package:plantdisese/ui/Detector.dart';
import 'package:plantdisese/ui/RegisterPage.dart';
import 'package:plantdisese/ui/detectornon.dart';
import 'package:plantdisese/ui/services/auth.dart';
import 'package:plantdisese/ui/shared/loading.dart';


class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
 
  final _formKey = GlobalKey<FormState>();
  String error = '';
    FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  bool _autoValidate = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String message="";


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: <Widget>[
                            FlatButton(
                              onPressed: () => {Navigator.pop(context)},
                              padding: EdgeInsets.all(10.0),
                              child: Row( // Replace with a Row for horizontal icon + text
                                children: <Widget>[
                                  Icon(
                                    Icons.arrow_back,
                                    color: Colors.pink,
                                    size: 25,
                                  ),
                                  SizedBox(width: 5,),
                                  Text("BACK",
                                      style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.pink,
                                      letterSpacing: 1))
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
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
                          ],  
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text("Login Now!",
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1)),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Nice to See you again!",
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.grey,
                                letterSpacing: 1)),
                        SizedBox(
                          height: 50,
                        ),
                        Form(
                          key: _formKey,
                          autovalidate: _autoValidate,
                          
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  validator: emailValidator,
                                  
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                  controller: _emailController,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                TextFormField(
                                  validator: pwdValidator,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    hintText: "******",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                  controller: _passwordController,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  child: Text("Forgot Password?",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1)),
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Row(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap:() async{
                                        if(_formKey.currentState.validate()){
                    
                     try{
              var result=    FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailController.text, password:_passwordController.text)
                      .then((AuthResult auth) {
                        FirebaseUser user = auth.user;
                        var userid=user.uid;
                   Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Detector("Logout",userid)),
        );
                  }).catchError((e) {
                    print(e);
                   setState(() {
                      message = "invalid password or username";
                   });
                    
                  });
                     }catch(e){
                         setState(() {
                      message = "invalid password or username";
                   });
                     }
                   
                  }
                },
                                      
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.pink),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.pink,
                                        ),
                                        child: Text("Login",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60,
                                    ),
                                    GestureDetector(onTap: _showMyDialog,
                                                                          child: Text("Need Help?",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.pink,
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(message,style: TextStyle(fontSize: 20.0,color: Colors.red),)
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
        ),
      ),
    );
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) return '*Required';
    if (!regex.hasMatch(value))
      return '*Enter a valid email';
    else
      return null;
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Need Help"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text("Contact to Developer",style: TextStyle(fontSize: 20),),
               Text("+923064314839",style: TextStyle(fontSize: 20),),
             
            ],
          ),
        ),
        actions: <Widget>[
          RaisedButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  );
}




}
