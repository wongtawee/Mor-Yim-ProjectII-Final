import 'package:flutter/material.dart';
import 'package:moryim/widgets/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyAppointmentScreen4 extends StatefulWidget {
  @override
  _MyAppointmentScreen4State createState() => _MyAppointmentScreen4State();
}

class _MyAppointmentScreen4State extends State<MyAppointmentScreen4> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;
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

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final TextEditingController nameController = TextEditingController()..text;
  // final TextEditingController passwordController =  TextEditingController();
  final TextEditingController mobileNoController = TextEditingController()
    ..text;
  final TextEditingController addressController = TextEditingController()..text;
  final TextEditingController emailController = TextEditingController()..text;
  final TextEditingController lineIdController = TextEditingController()..text;
  final TextEditingController ageController = TextEditingController()..text;
  final TextEditingController birthdayController = TextEditingController()
    ..text;
  final TextEditingController sexController = TextEditingController()..text;

  final RegExp emailRegExpression =
      RegExp('[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}');
  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
    FirebaseFirestore.instance
        .collection("profile")
        .doc(auth.currentUser.email)
        .get()
        .then((value) {
      emailController.text = value.data()["email"];
      nameController.text = value.data()["name"];
      mobileNoController.text = value.data()["mobileNo"];
      lineIdController.text = value.data()["lineID"];
      addressController.text = value.data()["address"];
      ageController.text = value.data()["age"];
      birthdayController.text = value.data()["birthday"];
      sexController.text = value.data()["sex"];
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('แก้ไขโปรไฟล์'),
        backgroundColor: Color(0xFF7369FF),
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      body: ListView(
        children: <Widget>[
          TextFormFieldWidget(
            obscureText: false,
            textController: nameController,
            autovalidate: true,
            textInputType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'ชื่อ-นามสกุล',
              hintText: 'กรุณาใส่ชื่อและนามสกุล',
              filled: true,
              fillColor: Color(0x21000000),
              prefixIcon: Icon(
                Icons.person,
              ),
            ),
            validator: (String value) {
              return null;
            },
          ),
          TextFormFieldWidget(
            obscureText: false,
            textController: birthdayController,
            autovalidate: true,
            textInputType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'วันเดือนปีเกิด',
              hintText: 'กรุณาใส่วันเดือนปีเกิด',
              filled: true,
              fillColor: Color(0x21000000),
              prefixIcon: Icon(
                Icons.person,
              ),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Enter Mobile No';
              }
              return null;
            },
          ),
//==================================================================
// TEXTFORM FIELD: ADDRESS
//==================================================================
          TextFormFieldWidget(
            obscureText: false,
            textController: ageController,
            autovalidate: true,
            textInputType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'อายุ',
              hintText: 'กรุณาใส่อายุ',
              filled: true,
              fillColor: Color(0x21000000),
              prefixIcon: Icon(
                Icons.person,
              ),
            ),
            validator: (String value) {
              // if (value.isEmpty) {return 'Enter Address';}
              return null;
            },
          ),
//==================================================================
// TEXTFORM FIELD: MOBILE
//==================================================================
          TextFormFieldWidget(
            obscureText: false,
            textController: sexController,
            autovalidate: true,
            textInputType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'เพศ',
              hintText: 'กรุณาใส่เพศ',
              filled: true,
              fillColor: Color(0x21000000),
              prefixIcon: Icon(
                Icons.person,
              ),
            ),
            validator: (String value) {
              return null;
            },
          ),
          TextFormFieldWidget(
            obscureText: false,
            textController: addressController,
            autovalidate: true,
            textInputType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'ที่อยู่',
              hintText: 'กรุณาใส่ที่อยู่',
              filled: true,
              fillColor: Color(0x21000000),
              prefixIcon: Icon(
                Icons.person,
              ),
            ),
            validator: (String value) {
              return null;
            },
          ),
          TextFormFieldWidget(
            obscureText: false,
            textController: mobileNoController,
            autovalidate: true,
            textInputType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'เบอร์โทรศัพท์',
              hintText: 'กรุณาใส่เบอร์โทรศัพท์',
              filled: true,
              fillColor: Color(0x21000000),
              prefixIcon: Icon(
                Icons.person,
              ),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return 'กรุณาใส่เบอร์โทรศัพท์';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 200.0,
                height: 50.0,
                color: Colors.blue.shade100,
                child: RaisedButton(
                    onPressed: () async {
                      fnSaveProfile(
                        email: emailController.text,
                        name: nameController.text,
                        address: addressController.text,
                        mobileNo: mobileNoController.text,
                        lineId: lineIdController.text,
                        age: ageController.text,
                        birthday: birthdayController.text,
                      );
                    },
                    child: Text('บันทึก',
                        style: TextStyle(color: Colors.black, fontSize: 15))),
              ),
              ElevatedButton(
                style: style,
                onPressed: signOut,
                child: Text(
                  'ออกจากระบบ',
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  fnSaveProfile({
    String email,
    String name,
    String address,
    String mobileNo,
    String lineId,
    String age,
    String birthday,
    String sex,
  }) async {
    await firestore.collection("profile").doc(auth.currentUser.email).set({
      'email': email,
      'name': name,
      'address': address,
      'mobileNo': mobileNo,
      'lineID': lineId,
      'age': age,
      'birthday': birthday,
      'sex': sex,
    }).then((value) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text('Register $email profile completed. ')));
    }).catchError((error) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Register $email profile error $error ')));
    });
  }
}
