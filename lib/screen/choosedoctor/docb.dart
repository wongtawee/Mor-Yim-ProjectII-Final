// ignore_for_file: unnecessary_statements

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moryim/models/student.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Docb extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final Widget widget;
  const Docb({Key key, this.title, this.hint, this.controller, this.widget})
      : super(key: key);

  @override
  _DocbState createState() => _DocbState();
}

class _DocbState extends State<Docb> {
  final formKey = GlobalKey<FormState>();
  Student myStudent = Student();
  //เตรียม firebase
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _appointmentCollection =
      FirebaseFirestore.instance.collection("DoctorB");

  List<DropdownMenuItem<String>> listDrop = [];
  String selected;
  void loadData() {
    listDrop = [];
    listDrop.add(new DropdownMenuItem(
      child: new Text('แผนกทั่วไป'),
      value: 'Tooth filling',
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text('แผนกอายุรกรรม'),
      value: 'change tire',
    ));
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text("จอง"),
                backgroundColor: Color(0xFF7369FF),
                automaticallyImplyLeading: true,
                actions: [],
                centerTitle: true,
                elevation: 4,
              ),
              body: Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "นัดหมายแพทย์ออนไลน์",
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "ชื่อ-นามสกุล",
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          height: 52,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 1.0)),
                          child: TextFormField(
                            validator:
                                RequiredValidator(errorText: "กรุณาป้อนชื่อ"),
                            onSaved: (String fname) {
                              myStudent.fname = fname;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "อีเมล์",
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          height: 52,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 1.0)),
                          child: TextFormField(
                            validator: MultiValidator([
                              EmailValidator(errorText: "อีเมลไม่ถูกต้อง"),
                              RequiredValidator(errorText: "กรุณาป้อนอีเมลล์")
                            ]),
                            onSaved: (String email) {
                              myStudent.email = email;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "วันที่นัดหมาย",
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          height: 52,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 1.0)),
                          child: TextFormField(
                            validator: RequiredValidator(
                                errorText: "กรุณาป้อนนามสกุล"),
                            // ignore: non_constant_identifier_names
                            onSaved: (String Date) {
                              myStudent.Date = Date;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "เวลา",
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          height: 52,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 1.0)),
                          child: TextFormField(
                            validator: RequiredValidator(
                                errorText: "กรุณาป้อนนามสกุล"),
                            onSaved: (String time) {
                              myStudent.time = time;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "รายการ",
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          height: 52,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 1.0)),
                          child: new Center(
                            child: new DropdownButton(
                                value: selected,
                                items: listDrop,
                                hint: new Text('Select Item'),
                                iconSize: 60,
                                iconDisabledColor: Colors.pink,
                                onChanged: (String list) {
                                  selected = myStudent.list = list;
                                  setState(() {});
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              child: Text(
                                "บันทึก",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () async {
                                if (formKey.currentState.validate()) {
                                  formKey.currentState.save();
                                  await _appointmentCollection.add({
                                    "fname": myStudent.fname,
                                    "Date": myStudent.Date,
                                    "email": myStudent.email,
                                    "list": myStudent.list,
                                    "time": myStudent.time
                                  });
                                  formKey.currentState.reset();
                                }
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
