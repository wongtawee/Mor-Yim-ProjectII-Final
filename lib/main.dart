import 'package:moryim/HomePage.dart';
import 'package:moryim/Login.dart';
import 'package:moryim/SignUp.dart';
import 'package:moryim/Start.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:moryim/screen/appointment/availiblity.dart';
import 'package:moryim/widgets/errorWidget.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize(
    debug: true,
  );
  initializeDateFormatting();

  // if (USE_FIRESTORE_EMULATOR) {
  //   FirebaseFirestore.instance.settings = Settings(
  //       host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
  // }

  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      runApp(MyApp());
    }
  } on SocketException catch (_) {
    runApp(NoInterConnectionApp());
    print('not connected');
  }
}

class NoInterConnectionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, routes: {
      '/': (context) => Scaffold(
            body: Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: NoInternetErrorWidget(),
            )),
          )
    });
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return //      <--- ChangeNotifierProvider
        MaterialApp(
      theme: ThemeData(primaryColor: Colors.orange),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      // home: _defaultHome,
      initialRoute: '/',
      routes: {
        "Login": (BuildContext context) => Login(),
        "SignUp": (BuildContext context) => SignUp(),
        "start": (BuildContext context) => Start(),
        "AvaliblityPage": (context) => AvailabilityPage(),
      },
    );
  }
}

class NotificationDotModel {}
