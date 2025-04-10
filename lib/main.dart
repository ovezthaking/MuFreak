import 'package:flutter/material.dart';
import 'package:mufreak/constants.dart';
import 'package:mufreak/views/screens/auth/login_screen.dart';
import 'package:mufreak/views/screens/auth/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MuFreak',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: SignupScreen(),
    );
  }
}
