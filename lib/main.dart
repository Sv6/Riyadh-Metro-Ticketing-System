import 'package:flutter/material.dart';
import 'package:riyadh_metro/client.dart';
import 'SignUp.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(
    title: "test",
    theme: ThemeData.dark(),
    home: LoginPage(),
    routes: {
      "/login/": (context) => LoginPage(),
      "/signUP/": (context) => SignUpPage(),
      "/Client/": (context) => ClientPage(clientName: ' ', balance: 100, availableTickets: ["d"]),
//testing git -z
    },
  ));
}
