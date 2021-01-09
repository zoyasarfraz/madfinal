import 'package:firebase_notes/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'notes.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:  StreamBuilder(
    stream: FirebaseAuth.instance.onAuthStateChanged,
    builder: (BuildContext context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: Text("Loading"),
        );
      } else {
        if (snapshot.hasData) {
          return notes();
        } else {
          return login();
        }
      }
    },
  )
  ));

}