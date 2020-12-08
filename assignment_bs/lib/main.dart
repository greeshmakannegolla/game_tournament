import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';
import 'LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn = (prefs.getBool('isLoggedIn') == null)
      ? false
      : prefs.getBool('isLoggedIn');

  runApp(MyApp(isLoggedIn));
}

class MyApp extends StatelessWidget {
  MyApp(this.isLoggedIn);
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? HomePage() : LoginPage(),
    );
  }
}
