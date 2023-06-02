import 'package:flutter/material.dart';
import 'package:riyadh_metro/FeedbackPage.dart';
import 'package:riyadh_metro/cancel.dart';
import 'package:riyadh_metro/client.dart';
import 'package:riyadh_metro/crud.dart';
import 'package:riyadh_metro/mapPage.dart';
import 'package:riyadh_metro/settings.dart';
import 'package:riyadh_metro/updateProfile.dart';
import 'DisplayTicket.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'SignUp.dart';
import 'login.dart';
import 'Wallet.dart';
import 'book.dart';
import 'Admin.dart';
import 'addAdmin.dart';
import 'DisplayFeedbacks.dart';
import 'FreezeAccount.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  

//test-z

  runApp(MaterialApp(
    title: "test",
    theme: ThemeData.dark(),
    home: LoginPage(),
    routes: {
      "/login/": (context) => LoginPage(),
      "/signUP/": (context) => SignUpPage(),
      "/Client/": (context) => ClientPage(
            clientName: '',
            balance: 100,
            availableTickets: const ["d"],
            walletID: "",
            pass: 0,
            stations: const [],
            date: const [],
            status: const [],
          ),
      "/Walllet/": (context) => walletPage(
            balance: 100,
            clientName: "clientName",
            walletID: "2",
            pass: 0,
          ),
      "/settings/": (context) => SettingsPage(),
      // "/Walllet/": (context) => walletPage(balance: 100, clientName: "clientName", walletID: "2"),
      "/book/": (context) => BookPage(
            clientName: "client",
            balance: 1,
            walletID: "",
            pass: 0,
            countCongestion: const [],
            timeCongestion: const [],
          ),
      "/DisplayTicket/": ((context) => (UpdateProfile())),
      "/FeedbackPage/": ((context) => (FeedbackPage())),
      "/updateProfile/": ((context) => (UpdateProfile())),
      "/DisplayTicket/": (context) =>
          (DisplayTicket(name: "", id: "", from: "", time: "", status: true)),
      "/mapPage/": (context) => (mapPage()),
      "/Admin/": ((context) => (Admin())),
      "/addAdmin/": (context) => (addAdmin()),
      "/DisplayFeedbacks/": (context) => (DisplayFeedback()),
      "/cancel/": (context) => (CancelPage()),
      "/FreezeAccount/": (context) => (FreezeAccount()),
    },
  ));
}
