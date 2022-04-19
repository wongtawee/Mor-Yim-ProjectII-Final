// ignore_for_file: deprecated_member_use, unnecessary_statements, unused_label, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moryim/models/student.dart';
import 'package:moryim/models/event.dart';
import 'package:moryim/screen/Service/Firebase/event_firestore_service.dart';

import 'package:form_field_validator/form_field_validator.dart';

class FormScreen extends StatefulWidget {
  final note;

  final String title;
  final String hint;
  final TextEditingController controller;
  final Widget widget;
  const FormScreen(
      {Key key, this.title, this.hint, this.controller, this.widget, this.note})
      : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _title;
  TextEditingController _description;
  // ignore: unused_field
  DateTime _eventDate;
  final formKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool processing;
  Student myStudent = Student();
  //เตรียม firebase
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _appointmentCollection =
      FirebaseFirestore.instance.collection("appointment");

  List<DropdownMenuItem<String>> listDrop = [];
  // ignore: avoid_init_to_null
  String selected = null;
  @override
  void initState() {
    super.initState();
    _title = TextEditingController(
        text: widget.note != null ? widget.note.title : "");
    _description = TextEditingController(
        text: widget.note != null ? widget.note.description : "");
    _eventDate = DateTime.now();
    processing = false;
  }

  void loadData() {
    listDrop = [];
    listDrop.add(new DropdownMenuItem(
      child: new Text('Tooth filling'),
      value: 'Tooth filling',
    ));
    listDrop.add(new DropdownMenuItem(
      child: new Text('change tire'),
      value: 'change tire',
    ));
  }

  @override
  Widget build(BuildContext context) {
    DateTime _dateTime = DateTime.now();
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
                title: Text("Book an Appointment"),
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
                                EmailValidator(
                                    errorText: "รูปแบบอีเมลไม่ถูกต้อง"),
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
                            height: 100,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.0)),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 90,
                                  child: CupertinoDatePicker(
                                      initialDateTime: _dateTime,
                                      onDateTimeChanged: (dateTime) {
                                        print(dateTime);
                                        setState(
                                          () {
                                            _dateTime = dateTime;
                                            onsaved:
                                            (String _dateTime) {
                                              myStudent.dateTime = _dateTime;
                                            };
                                          },
                                        );
                                      }),
                                )
                              ],
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
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      processing = true;
                                    });
                                    if (formKey.currentState.validate()) {
                                      formKey.currentState.save();
                                      await _appointmentCollection.add({
                                        "fname": myStudent.fname,
                                        "dateTime": myStudent.dateTime,
                                        "email": myStudent.email,
                                        "list": myStudent.list,
                                        "time": myStudent.time,
                                        "event_date": widget.note.eventDate
                                      });
                                      formKey.currentState.reset();
                                    }
                                  }
                                }),
                          ),
                          const SizedBox(height: 10.0),
                          ListTile(
                            title: Text("Date (YYYY-MM-DD)"),
                            subtitle: Text(
                                "${_eventDate.year} - ${_eventDate.month} - ${_eventDate.day}"),
                            onTap: () async {
                              DateTime picked = await showDatePicker(
                                  context: context,
                                  initialDate: _eventDate,
                                  firstDate: DateTime(_eventDate.year - 5),
                                  lastDate: DateTime(_eventDate.year + 5));
                              if (picked != null) {
                                setState(() {
                                  _eventDate = picked;
                                });
                              }
                            },
                          ),
                        ]),
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

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }
}
