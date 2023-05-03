import 'package:flutter/material.dart';
import 'SignUp.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(
    title: "test",
    theme: ThemeData.dark(),
    home: LoginPage(), // you forgot the home page -f
    routes: {
      "/login/": (context) => LoginPage(),
      "/SignUp/": (context) => SignUpPage()
    },
  ));
}
