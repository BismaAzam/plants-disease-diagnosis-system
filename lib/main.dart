import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantdisese/ui/welcome.dart';


void main() {
  runApp(MyApp());
}


String username;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Welcome(),
    );
  }
}
