import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moryim/chat/chat_screen.dart';
import 'package:moryim/screen/choosedisplay/choosedisplay.dart';
import 'screen/appointment/my_appointment_screen.dart';
import 'screen/appointment/my_appointment_screen4.dart';
import 'chat/chat_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../constants.dart';
import 'screen/appointment/availiblity.dart';
import 'package:moryim/screen/choosedisplay/choosedisplay.dart';
import 'screen/appointment/formscreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;
  final List<Widget> _pages = [
    MyAppointmentScreen(),
    AvailabilityPage(),
    Choosedisplay(),
    MyAppointmentScreen4(),
    ChatScreen(),
  ];
  int _selectedPage = 0;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPage],
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(defaultPadding),
        color: Colors.white,
        child: SafeArea(
          child: GNav(
            haptic: true,
            tabBorderRadius: 15,
            curve: Curves.ease,
            duration: Duration(milliseconds: 350),
            gap: 8,
            color: Colors.grey[800],
            activeColor: Colors.white,
            iconSize: 24,
            tabBackgroundColor: primaryColor,
            padding: EdgeInsets.symmetric(
              horizontal: defaultPadding,
              vertical: defaultPadding / 2,
            ),
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'หน้าแรก',
              ),
              GButton(
                icon: Icons.people,
                text: 'จอง',
              ),
              GButton(
                icon: Icons.content_paste,
                text: 'ข้อมูล',
              ),
              GButton(
                icon: Icons.person,
                text: 'บัญชี',
              ),
              GButton(
                icon: IconData(0xe154, fontFamily: 'MaterialIcons'),
                text: 'แชท',
              )
            ],
            onTabChange: (pageNum) {
              setState(() {
                _selectedPage = pageNum;
              });
            },
          ),
        ),
      ),
    );
  }
}
