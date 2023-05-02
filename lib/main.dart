import 'package:flutter/material.dart';
import 'SignUp.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(
    title: "test",
    theme: ThemeData.dark(),
    routes: {
      "/login/": (context) => LoginPage(),
      "/signUP/": (context) => SignUpPage()
    },
  ));
}
