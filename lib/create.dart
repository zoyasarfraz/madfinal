import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class create extends StatefulWidget {
  @override
  _createState createState() => _createState();
}


class _createState extends State<create> {
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
  final title = new TextEditingController();
  final body = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          submit();
        },

        child: Icon(Icons.check),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.lightGreenAccent,
          height: 80,
        ),
      ),
      backgroundColor: Color(0xff121212),
      appBar: AppBar(
        title: Text("Notes App"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                    color: Color(0xa1ffffff)),
                child: TextField(
                  controller: title,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                      fillColor: Colors.white,
                      focusColor: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                  color: Color(0xa1ffffff),
                ),
                child: TextField(
                  maxLines: 15,
                  controller: body,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Body',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  submit() async {
    setState(() {});
    print("***************************");
    print(title.text + "\n\n\n" + body.text);
    await Firestore.instance
        .collection('users')
        .document(user).collection('notes').document()
        .setData({'title': title.text, 'body': body.text});
    Navigator.pop(context);
  }
}
