import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moryim/screen/Choosedoctor/doca.dart';
import 'package:moryim/screen/Choosedoctor/docb.dart';

class Choosedoctor extends StatefulWidget {
  const Choosedoctor({Key key}) : super(key: key);

  @override
  _ChoosedoctorState createState() => _ChoosedoctorState();
}

class _ChoosedoctorState extends State<Choosedoctor> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("จอง"),
        backgroundColor: Color(0xFF7369FF),
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 8, 0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.44,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Color(0xFFCFD4DB),
                                          width: 1,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 5, 12, 5),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'นายแพทย์ดำรง',
                                              style: TextStyle(
                                                fontFamily: 'Lexend Deca',
                                                color: Color(0xFF57636C),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.44,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Color(0xFFCFD4DB),
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 5, 12, 5),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'แพทย์หญิงจิรดา',
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF57636C),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 180,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                  ),
                                  alignment: AlignmentDirectional(
                                      -0.050000000000000044, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Image.asset(
                                        'assets/images/Salina_Zaman.png',
                                        width: 150,
                                        height: 300,
                                        fit: BoxFit.contain,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 210,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                  ),
                                  child: Image.asset(
                                    'assets/images/doctor_big_preview.png',
                                    width: 150,
                                    height: 200,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.44,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color(0xFFCFD4DB),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 5, 12, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Doca()),
                                );
                              },
                              child: Text(
                                'Appointment',
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF57636C),
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.calendar_month,
                              color: Color(0xFF57636C),
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.44,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color(0xFFCFD4DB),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 5, 12, 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Docb()),
                              );
                            },
                            child: Text(
                              'Appointment',
                              style: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF57636C),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.calendar_month,
                            color: Color(0xFF57636C),
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
