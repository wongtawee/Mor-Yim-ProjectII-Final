// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moryim/Login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name, _email, _password;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (user != null) {
          await _auth.currentUser.updateProfile(displayName: _name);
        }
      } catch (e) {
        showError(e.message);
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              child: Image(
                image: AssetImage("assets/images/login.jpg"),
                fit: BoxFit.contain,
              ),
            ),
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                          // ignore: missing_return
                          validator: (input) {
                            if (input.isEmpty) return 'Enter Name';
                          },
                          decoration: InputDecoration(
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.person),
                          ),
                          onSaved: (input) => _name = input),
                    ),
                    Container(
                      child: TextFormField(
                          // ignore: missing_return
                          validator: (input) {
                            if (input.isEmpty) return 'Enter Email Address';
                          },
                          decoration: InputDecoration(
                              labelText: 'Email Address',
                              prefixIcon: Icon(Icons.email)),
                          onSaved: (input) => _email = input),
                    ),
                    Container(
                      child: TextFormField(
                          // ignore: missing_return
                          validator: (input) {
                            if (input.length < 6)
                              return 'Provide Minimum 6 Character';
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                          onSaved: (input) => _password = input),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: style,
                      onPressed: signUp,
                      child: Text(
                        'SignUp',
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
