import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'create.dart';

class notes extends StatefulWidget {
  @override
  _notesState createState() => _notesState();
}

class _notesState extends State<notes> {
  var user;
  @override
  void initState() {

    // TODO: implement initState
    some();
   print(user);
   print("*****************************");
    super.initState();
  }
  some() async{
    final FirebaseUser userw = await FirebaseAuth.instance.currentUser();
    final String uide = userw.uid.toString();
    setState(() {
      user = uide;
    });
  }
  @override
  Widget build(BuildContext context) {

    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff121212),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          transport(create());
        },
        child: Icon(Icons.add),
        elevation: 0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.black,
          height: 50,
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              FirebaseAuth.instance.signOut();
            },
            child: Icon(Icons.exit_to_app, color: Colors.white,),
          )
        ],
        title: Text("Notes App"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('users').document(user).collection('notes').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return new Text('Loading...');
            default:
              return new ListView(
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 0,
                      color: Color(0x11ffffff),
                      child: new ListTile(
                        title: new Text(document['title'], style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),

                        subtitle: new Text(document['body'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
                      ),
                    ),
                  );
                }).toList(),
              );
          }
        },
      )
    );
  }
  transport(Widget n) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => n));
  }
}
