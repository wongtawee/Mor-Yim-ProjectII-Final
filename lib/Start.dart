import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        final UserCredential user =
            await _auth.signInWithCredential(credential);

        await Navigator.pushReplacementNamed(context, "/");

        return user;
      } else {
        throw StateError('Missing Google Auth Token');
      }
    } else
      throw StateError('Sign in Aborted');
  }

  navigateToLogin() async {
    Navigator.pushReplacementNamed(context, "Login");
  }

  navigateToRegister() async {
    Navigator.pushReplacementNamed(context, "SignUp");
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 35.0),
            Container(
              height: 450,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/bg.jpg"),
              )),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome to MorYim',
                  style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                )
              ],
            ),
            RichText(
                text: TextSpan(
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: <TextSpan>[
                  TextSpan(
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue))
                ])),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    style: style,
                    onPressed: navigateToLogin,
                    child: Text(
                      'LOGIN',
                    )),
                SizedBox(width: 60.0),
                ElevatedButton(
                  style: style,
                  onPressed: navigateToRegister,
                  child: Text(
                    'REGISTER',
                  ),
                )
              ],
            ),
            GestureDetector(child: Text('ลืมรหัสผ่าน'))
          ],
        ),
      ),
    );
  }
}
