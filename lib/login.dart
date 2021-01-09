import 'package:firebase_notes/notes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'signup.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {

  TextEditingController uname = new TextEditingController();
  TextEditingController pwd = new TextEditingController();
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
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
        statusBarColor: Colors.purple[700],
      systemNavigationBarColor: Colors.yellowAccent[800]
    ));
    return SafeArea(
      child: Scaffold(
        /*appBar: AppBar(
          title: Text("Fire Notes"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),*/
        backgroundColor: Colors.transparent,
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
              child: Center(child: forma()),
            ),
          ),
        ),
      ),
    );
  }
  void _navigateToNextScreen(BuildContext context, Widget n) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => n),
    );
  }

  logine() async{
    print("************************");
    print("*******************************************************");
    /*print(uname.text + " " + pwd.text);*/
    FirebaseAuth.instance.signInWithEmailAndPassword(email: uname.text, password: pwd.text).then((value){
      print(value.user.uid);
      _navigateToNextScreen(context, notes());
    });

  }
  Widget forma(){
    return Form(
      autovalidate: false,
      key: _formKey,
      child: Wrap(
        children: <Widget>[
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
          Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width/1,
                    height: MediaQuery.of(context).size.height / 14,
                    child: FlatButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          logine();
                        }
                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      child: Text("LOGIN" , style: TextStyle(fontSize: 20, color: Colors.purple),),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "OR"
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width/1,
                    height: MediaQuery.of(context).size.height / 20,

                    child: OutlineButton(
                      onPressed: () {
                        _navigateToNextScreen(context, signup());
                      },

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      child: Text("SIGN UP", style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
