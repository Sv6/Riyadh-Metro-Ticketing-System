import 'package:flutter/material.dart';
import 'package:riyadh_metro/client.dart';
import 'SignUp.dart';
import 'login.dart';
import 'Wallet.dart';
void main() {
  runApp(MaterialApp(
    title: "test",
    theme: ThemeData.dark(),
    home: LoginPage(),
    routes: {
      "/login/": (context) => LoginPage(),
      "/signUP/": (context) => SignUpPage(),
      "/Client/": (context) => ClientPage(clientName: ' ', balance: 100, availableTickets: ["d"]),
      "/Walllet/": (context) => walletPage(balance: 100, clientName: "clientName", walletID: "2"),
      // "/Walllet/": (context) => walletPage(balance: 100, clientName: "clientName", walletID: "2"),
      // "/Book/": (context) => Bookpage(clientName: "clientName", balance: 1, destinations: ["destinations"], selectedDestination: "selectedDestination", availableTickets: ["d"], selectedTicket:" 67" ),
//testing git -z
    },
  ));
}
