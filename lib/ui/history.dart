import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';


class History extends StatefulWidget {
   
  String _usserid;

  History(String usserid ) {
    
    this._usserid=usserid;
  }
  
  
  
  
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
Color _color=Colors.blueGrey[200];




  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text("History"),
      ),
      body:
     StreamBuilder<QuerySnapshot>(
  stream: Firestore.instance.collection('users').document(widget._usserid).collection('userDetect').snapshots(),
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasError)
        return new Text('Error: ${snapshot.error}');
    switch (snapshot.connectionState) {
        case ConnectionState.waiting: return new Text('Loading...');
        default:
      return new ListView(
        children: snapshot.data.documents.map((DocumentSnapshot document) {
     return new Card(

          semanticContainer: true,
         color:Colors. blueGrey[200],
         child: Column(
           children: <Widget>[
           Text(document['result'],style: TextStyle(
               color: Colors.black,
               fontSize: 15,
               fontWeight: FontWeight.w500)),
                SizedBox(height:10),  
                Text(document['confidence'].toString(),style: TextStyle(
               color: Colors.black,
               fontSize: 15,
               fontWeight: FontWeight.w500)),
                SizedBox(height:10),  
                 Text(document['timestamp'].toDate().toString(),style: TextStyle(
               color: Colors.black,
               fontSize: 15,
               fontWeight: FontWeight.w500)),
                SizedBox(height:10),  
                
                SizedBox(height:10),  
              
              
           ],
         ),            
       );
        }).toList(),
      );
    }})
    );
  }
}