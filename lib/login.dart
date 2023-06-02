import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:riyadh_metro/SignUp.dart';
import 'package:riyadh_metro/client.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'crud.dart';
import 'validator.dart';
import 'Admin.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(LoginPage());
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _myAppState();
}

class _myAppState extends State<LoginPage> {
  bool hidePass = true;
  Crud CRUD = Crud();

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/images/map.jpg'), context);
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(
                    255, 6, 179, 107)), 
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(
                    255, 6, 179, 107)), 
          ),
          prefixStyle: TextStyle(
            color: Colors.white, 
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(

                children: [
                  SizedBox(height: 50.0),
                  // ========================= LOGO =========================
                  Center(
                    child: Image.asset(
                      'assets/images/LogoUpdated.png',
                      width: 300.0,
                      height: 300.0,
                    ),
                  ),
                  //========================= SIGN IN TEXT =========================
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 15.0),
                          child: Divider(
                            color: Color.fromARGB(255, 6, 179, 107),
                            height: 10,
                          ),
                        ),
                      ),
                      Text(
                        'Sign in',
                        style: TextStyle(
                          color: Color.fromARGB(255, 6, 179, 107),
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 15.0),
                          child: Divider(
                            color: Color.fromARGB(255, 6, 179, 107),
                            height: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.0),
                  // ========================= email =========================
                  SizedBox(
                    width: 300.0,
                    child: TextField(
                      controller: _email,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // ========================= PASSWORD =========================
                  SizedBox(
                    width: 300.0,
                    child: TextField(
                      controller: _password,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              hidePass = !hidePass;
                            });
                          },
                          child: Icon(hidePass
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      obscureText: hidePass,
                    ),
                  ),
                  // ========================= FORGOT PASSWORD =========================
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color.fromARGB(255, 6, 179, 107),
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 50.0),

                  // ========================= LOGIN BUTTON =========================
                  SizedBox(
                    width: 300.0,
                    height: 50.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 6, 179, 107),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () async {
                        bool validate = true;
                        final email = _email.text;
                        final password = _password.text;

                        try {
                          final userCredential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email, password: password);
                        } on FirebaseAuthException {
                          const snackBar = SnackBar(
                              content: Text("Email or password is invalid"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          validate = false;
                        } catch (e) {
                          validate = false;
                        }

                        if (validate == true) {
                          Validator valid = Validator();
                          String uid = await CRUD.getId();
                          Map<String, dynamic> data =
                              await CRUD.getUserData(uid);
                          if (valid.isAdmin(_email.text)) {
                            Map<String, dynamic> data =
                                await CRUD.getAdminData(uid);
                            if (data["STATUS"]) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Admin()));
                            } else {
                              const snackBar =
                                  SnackBar(content: Text("Account is Frozen"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          } else {
                            if (data["STATUS"]) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ClientPage(
                                    clientName: data["FULLNAME"],
                                    balance: data["BALANCE"] * 1.0,
                                    availableTickets: data["TICKETS"],
                                    walletID: data["WALLETID"],
                                    pass: data["PASS"],
                                    stations: const [],
                                    date: const [],
                                    status: const [],
                                  ),
                                ),
                              );
                            } else {
                              const snackBar =
                                  SnackBar(content: Text("Account is Frozen"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // ========================= REGISTER =========================
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignUpPage()));
                    },
                    child: Text(
                      'Don\'t have an account? Register.',
                      style: TextStyle(
                        color: Color.fromARGB(255, 6, 179, 107),
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
