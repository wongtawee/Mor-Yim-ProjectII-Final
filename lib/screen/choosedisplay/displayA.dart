import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayA extends StatefulWidget {
  @override
  _DisplayAState createState() => _DisplayAState();
}

class _DisplayAState extends State<DisplayA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book an Appointment")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("DoctorA").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                children: snapshot.data.docs.map((document) {
                  return Container(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: FittedBox(
                          child: Text(document["list"]),
                        ),
                      ),
                      title: SizedBox(
                        height: 18,
                        child: Container(
                          child: Text(document["fname"] +
                              document["Date"] +
                              document["time"]),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
