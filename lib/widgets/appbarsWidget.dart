import 'package:moryim/screen/Service/Firebase/readData.dart';
import 'package:moryim/screen/utilities/color.dart';
import 'package:moryim/screen/utilities/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HAppBarWidget extends StatelessWidget {
  @required
  final String uId;
  @required
  final String title;
  HAppBarWidget({this.title, this.uId});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(left: 0.0),
        child: Text(
          title,
          style: kAppbarTitleStyle,
        ),
      ),
      backgroundColor: appBarColor,
      actions: <Widget>[
        Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: StreamBuilder(
                stream: ReadData.fetchNotificationDotStatus(uId),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? Container()
                      : IconButton(
                          icon: Stack(),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              "/NotificationPage",
                            );
                          }
                          //

                          );
                }))
      ],
    );
  }
}

class CAppBarWidget extends StatelessWidget {
  @required
  final String title;
  CAppBarWidget({this.title});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: appBarIconColor //change your color here
          ),
      title: Text(
        title,
        style: kAppbarTitleStyle,
      ),
      centerTitle: true,
      backgroundColor: appBarColor,
      actions: <Widget>[
        StreamBuilder(
            stream: ReadData.fetchNotificationDotStatus(
                FirebaseAuth.instance.currentUser.uid),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Container()
                  : IconButton(
                      icon: Stack(),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          "/NotificationPage",
                        );
                      }
                      //

                      );
            })
      ],
    );
  }
}
