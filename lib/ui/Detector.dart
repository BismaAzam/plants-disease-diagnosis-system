import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plantdisese/ui/SignInPage.dart';
import 'package:plantdisese/ui/history.dart';
import 'package:plantdisese/ui/services/auth.dart';
import 'package:plantdisese/ui/tensorflow.dart';
import 'package:image_picker/image_picker.dart';


final usersRef = Firestore.instance.collection('users');
final postsRef = Firestore.instance.collection('users');

class Detector extends StatefulWidget {
  
  String _tit;
  String _usserid;

  Detector(String tit,String usserid ) {
    this._tit= tit;
    this._usserid=usserid;
  }
   

  @override
  _DetectorState createState() => _DetectorState();
}

class _DetectorState extends State<Detector> {
  Tensorflow tensor =
      new Tensorflow(model: "assets/plant_disease_model.tflite", labels: "assets/plant_labels.txt");
  File _image;
  List _recognitions = [];
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
    tensor.loadModel();
  }

  selectFromImagePicker() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _image = image;
    });
   
  }

  selectFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (image == null) return;
    setState(() {
      _image = image;
    });
    
  } 
   detect() async {

    List recognitions = await tensor.predictImage(_image);
    setState(() {
      _recognitions=recognitions;
      
    });
  

 
    
    final DateTime timestamp = DateTime.now();
    
    postsRef
        .document(widget._usserid)
        .collection("userDetect")
        .document()
        .setData({
      
      "ownerId": widget._usserid ,
      "result": _recognitions[0]['label'],
      "confidence": _recognitions[0]['confidence'],
      "timestamp": timestamp,
      
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(backgroundColor:Colors.blueGrey[900] , elevation: 0.0,
      actions: <Widget>[
        FlatButton(onPressed:() async{ _auth.signOut();
         Navigator.pop(
          context,
          MaterialPageRoute(
              builder: (context) => SignInPage())
        );
        
        } , child: Text(widget._tit,style: TextStyle(color:Colors.white),)),

        FlatButton(onPressed:() { 
         Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => History(widget._usserid))
        );
        
        } , child: Text("History",style: TextStyle(color:Colors.white),))
      ],
      ),
      body: ListView(
   children: <Widget>[
     Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Plant Disease Detector",
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1)),
            SizedBox(
              height: 30,
            ),
            Text("Take an image of plant leaf",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1)),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () => selectFromCamera(),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.pink,
                    ),
                    child: Text("Capture",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1)),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () => selectFromImagePicker(),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.pink,
                    ),
                    child: Text("Gallery",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),


            _image == null ? Container(  height: 250 ,width:250 ,  decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepPurple),
                      ),child: Center(child: Text('No image selected.',style: TextStyle(color:Colors.grey),)))
            
             : Container(
                decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepPurple),),
              height: 250,
              child: Image.file(_image)),

              SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () => detect(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.pink),
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.pink,
                ),
                child: Text("Detect",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1)),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            new Container(
              height: 200.0,
              child: ListView.builder(
                itemCount: _recognitions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Center(
                      child:
                      _recognitions[index]['confidence'] >0.87 ?
                       Text("Results:"+_recognitions[index]['label'],  style: TextStyle(
                      fontSize: 22,
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1))
                      :
                       Text("Results:Unpredictible image",  style: TextStyle(
                      fontSize: 22,
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1)),
                    ),
                    subtitle: Center(
                      child: 
                      _recognitions[index]['confidence'] >0.87 ?
                      Text(
                          "Confidence ${_recognitions[index]['confidence'].toString()}", style: TextStyle(
                      fontSize: 15,
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1))
                      :
                      Text("Confidence:",  style: TextStyle(
                      fontSize: 22,
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1)),
                      
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
   ],

      )
      ,
     
    );
  }
}
