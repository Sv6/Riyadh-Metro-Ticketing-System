import 'dart:js';

import 'package:flutter/material.dart';
import 'package:riyadh_metro/client.dart';
import 'package:riyadh_metro/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'SignUp.dart';
import 'login.dart';
import 'Wallet.dart';
import 'book.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MaterialApp(
    title: "test",
    theme: ThemeData.dark(),
    home: LoginPage(),
    routes: {
      "/login/": (context) => LoginPage(),
      "/signUP/": (context) => SignUpPage(),
      "/Client/": (context) =>
          ClientPage(clientName: ' ', balance: 100, availableTickets: ["d"]),
      "/Walllet/": (context) =>
          walletPage(balance: 100, clientName: "clientName", walletID: "2"),
      "/settings/": (context) => SettingsPage(),
      // "/Walllet/": (context) => walletPage(balance: 100, clientName: "clientName", walletID: "2"),
      "/book/": (context) => BookPage(
          clientName: "client",
          balance: 1,
          destinations: ["destinations"],
          selectedDestination: "selected",
          availableTickets: ["d"],
          selectedTicket: "67")

//testing git -z
    },
  ));
}
