import 'package:firebase_notes/login.dart';
import 'package:firebase_notes/notes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {

  TextEditingController uname = new TextEditingController();
  TextEditingController pwd = new TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/2.png"),
              fit: BoxFit.fill,
            ),
          ),
          width: MediaQuery.of(context).size.width / 1,
          height: MediaQuery.of(context).size.height / 1,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(child: forma(),),
          ),
        ),
      ),
    );
  }
  void _navigateToNextScreen(BuildContext context, Widget n) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => n),
    );
  }
  signupe() async{
    print("*******************************************************");
    print(uname.text + " " + pwd.text);
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: uname.text,
      password: pwd.text,
    ))

        .user;
    print(user.uid);
    Firestore.instance.collection('users').document(user.uid).setData({});
    _navigateToNextScreen(context, notes());

  }
  Widget forma(){
    return Form(
      autovalidate: false,
      key: _formKey,
      child: Wrap(
        children: <Widget>[
          /*Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: uname,
              validator: validateEmail *//*(value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      }*//*,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                labelText: 'Username (Mail ID)',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              controller: pwd,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                labelText: 'Password',
              ),
            ),
          ),*/
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                color: Color(0x41ffffff),
                child: Theme(
                  data: new ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Color(0xafffffff)
                  ),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white, height: 2.0 ),

                    keyboardType: TextInputType.emailAddress,
                    controller: uname,
                    validator: validateEmail /*(value) {
                                if (value.isEmpty) {
                                  return 'Please enter Your Mail ID';
                                }
                                return null;
                              }*/,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail_outline, color: Color(0xafffffff),),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
                      labelText: 'USERNAME (MAIL ID)',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                color: Color(0x41ffffff),
                child: Theme(
                  data: new ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.white,
                      hintColor: Color(0xafffffff)
                  ),
                  child: TextFormField(
                    style: TextStyle(height: 2.0, color: Colors.white),
                    controller: pwd,
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline, color: Color(0xafffffff),),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
                      labelText: 'PASSWORD',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width/1,
                    height: MediaQuery.of(context).size.height / 14,
                    child: FlatButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          signupe();
                        }

                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      child: Text("SIGN UP", style: TextStyle(fontSize: 20, color: Colors.purple),),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("OR"),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width/1,
                    height: MediaQuery.of(context).size.height / 14,

                    child: OutlineButton(
                      onPressed: () {
                        /*_navigateToNextScreen(context, login());*/
                        Navigator.pop(context);
                      },
                      borderSide: BorderSide(width: 3, color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      child: Text("BACK TO LOGIN", style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              )
            ],
          )
        ],
      ),
    );
  }
}
