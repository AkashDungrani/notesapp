import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/view/screens/detailpage.dart';
import 'package:notes_app/view/screens/homepage.dart';
import 'package:notes_app/view/screens/login.dart';
import 'package:notes_app/view/screens/read.dart';
import 'package:notes_app/view/screens/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FCMNotificationHelper.fcmNotificationHelper.FCMinitialization();

  String? email;
  String? password;

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
    ),
    initialRoute: "splash",
    routes: {
      "splash": (context) => SplashScreen(),
      "/": (context) => HomePage(),
      "login": (context) => LogInPage(),
      "addnote":(context) => AddNote(),
    },
  ));
}
