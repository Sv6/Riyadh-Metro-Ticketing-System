import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riyadh_metro/client.dart';
import 'login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(SignUpPage());
}

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool hidePass = true;
  late final TextEditingController _name;
  late final TextEditingController _birthDate;
  late final TextEditingController _username;
  late final TextEditingController _password;
  late final TextEditingController _passwordConfirm;
  late final TextEditingController _email;
  late final TextEditingController _phone;

  @override
  void initState() {
    // TODO: implement initState
    _name = TextEditingController();
    _birthDate = TextEditingController();
    _username = TextEditingController();
    _password = TextEditingController();
    _passwordConfirm = TextEditingController();
    _email = TextEditingController();
    _phone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _birthDate.dispose();
    _username.dispose();
    _password.dispose();
    _passwordConfirm.dispose();
    _email.dispose();
    _phone.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signup Page',
      theme: ThemeData(
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 6, 179, 107),
            ), // set the border color to green
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 6, 179, 107),
            ), // set the border color to green
          ),
          prefixStyle: TextStyle(
            color: Colors.white, // set the prefix icon color to white
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ========================= LOGO =========================

                  //========================= SIGN UP TEXT =========================
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
                        'Sign up',
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
                  // ========================= FULL NAME =========================
                  Container(
                    width: 300.0,
                    child: TextFormField(
                      controller: _name,
                      decoration: InputDecoration(
                        hintText: 'Full Name',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // ========================= BIRTH DATE =========================
                  Container(
                    width: 300.0,
                    child: TextFormField(
                      controller: _birthDate,
                      decoration: InputDecoration(
                        hintText: 'Birth Date',
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // ========================= USERNAME =========================
                  Container(
                    width: 300.0,
                    child: TextFormField(
                      controller: _username,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // ========================= PASSWORD =========================
                  Container(
                    width: 300.0,
                    child: TextFormField(
                      controller: _password,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            // setState(() {
                            //   hidePass = !hidePass;
                            // });
                          },
                          child: Icon(hidePass
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      obscureText: hidePass,
                    ),
                  ),
                  // ========================= PASSWORD VERIFICATION =========================
                  SizedBox(height: 20.0),
                  Container(
                    width: 300.0,
                    child: TextFormField(
                      controller: _passwordConfirm,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            // setState(() {
                            //   hidePass = !hidePass;
                            // });
                          },
                          child: Icon(hidePass
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      obscureText: hidePass,
                    ),
                  ),
                  // ========================= EMAIL =========================
                  SizedBox(height: 20.0),
                  Container(
                    width: 300.0,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _email,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  // ========================= PHONE NUMBER =========================
                  SizedBox(height: 20.0),
                  Container(
                    width: 300.0,
                    child: TextFormField(
                      controller: _phone,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                  ),
                  // ========================= SIGN UP BUTTON =========================
                  SizedBox(height: 50.0),
                  Container(
                    width: 300.0,
                    height: 50.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 6, 179, 107),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      // .on error after on pressevd
                      onPressed: () async {
                        final email = _email.text;
                        final password = _password.text;

                        final userCredential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: email, password: password);
                        print(userCredential);
                        // FirebaseAuth.instance
                        //     .createUserWithEmailAndPassword(
                        //         email: _email.text, password: _password.text)
                        //     .then((value) => addingUser())
                        //     .then((value) => {
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) => ClientPage(
                        //                       clientName: _name.text,
                        //                       balance: 0.0,
                        //                       availableTickets: ["d"])))
                        //         });
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // ========================= SIGN IN =========================
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(
                      'Already have an account? Sign in.',
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

//code caused alot of errors when trying to initialize firebase
  // void addingUser() {
  //   var user = <String, dynamic>{
  //     "name": _name.text,
  //     "birthdate": _birthDate.text,
  //     "username": _username.text,
  //     "password": _password.text,
  //     "email": _email,
  //     "phone": _phone
  //   };
  //   db.collection("user").add(user).then((DocumentReference doc) =>
  //       print('DocumentSnapshot added with ID: ${doc.id}'));
  // }
}
