import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:riyadh_metro/client.dart';
import 'login.dart';
import 'validator.dart';
import 'crud.dart';
import 'package:intl/intl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(SignUpPage());
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool hidePass = true;
  final Validator validate = Validator();
  final Crud CRUD = Crud();
  final _formKey = GlobalKey<FormState>();
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
                  SizedBox(
                    height: 90,
                  ),
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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // ========================= FULL NAME =========================
                        SizedBox(
                          width: 300.0,
                          child: TextFormField(
                            validator: (value) {
                              if (!validate.validateName(name: value)) {
                                return "enter a valid name";
                              }
                              return null;
                            },
                            controller: _name,
                            decoration: InputDecoration(
                              hintText: 'Full Name',
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        // ========================= BIRTH DATE =========================
                        SizedBox(
                          width: 300.0,
                          child: TextFormField(
                            controller: _birthDate,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: 'Birth Date',
                              prefixIcon: Icon(Icons.calendar_today),
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime(2000),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2008));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                setState(() {
                                  _birthDate.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {}
                            },
                          ),
                        ),
                        SizedBox(height: 20.0),
                        // ========================= PASSWORD =========================
                        SizedBox(
                          width: 300.0,
                          child: TextFormField(
                            validator: (value) {
                              if (!validate.validatePassword(password: value)) {
                                return "6+ chars, 1 uppercase, 1 lowercase, 1 digit required.";
                              }
                              return null;
                            },
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
                        // ========================= PASSWORD VERIFICATION =========================
                        SizedBox(height: 20.0),
                        SizedBox(
                          width: 300.0,
                          child: TextFormField(
                            validator: (value) {
                              if (!validate.verifyPassword(
                                  p1: value, p2: _password.text)) {
                                return "passwords does not match";
                              }
                              return null;
                            },
                            controller: _passwordConfirm,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
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
                        // ========================= EMAIL =========================
                        SizedBox(height: 20.0),
                        SizedBox(
                          width: 300.0,
                          child: TextFormField(
                            validator: (value) {
                              if (!validate.validateEmail(email: value)) {
                                return "email is not valid";
                              }
                              return null;
                            },
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
                        SizedBox(
                          width: 300.0,
                          child: TextFormField(
                            validator: (value) {
                              if (!validate.validatePhone(phone: value)) {
                                return "phone number not valid (05xxxxxxxx)";
                              }
                              return null;
                            },
                            controller: _phone,
                            decoration: InputDecoration(
                              hintText: '(05xxxxxxxx)',
                              prefixIcon: Icon(Icons.phone),
                            ),
                          ),
                        ),
                        // ========================= SIGN UP BUTTON =========================
                        SizedBox(height: 50.0),
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
                              try {
                                if (_formKey.currentState!.validate()) {
                                  final email = _email.text;
                                  final password = _password.text;

                                  final userCredential = await FirebaseAuth
                                      .instance
                                      .createUserWithEmailAndPassword(
                                          email: email, password: password);
                                  final walledID = CRUD.idGenerator();
                                  FirebaseAuth auth = FirebaseAuth.instance;
                                  final uid = auth.currentUser!.uid;
                                  if (!CRUD.insertClient(
                                      uid,
                                      _name.text,
                                      0.0,
                                      _birthDate.text,
                                      email,
                                      _phone.text,
                                      walledID,
                                      _password.text,
                                      true,
                                      [],
                                      0)) {
                                    throw Exception("error occured");
                                  }
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ClientPage(
                                            clientName: _name.text,
                                            balance: 0.0,
                                            availableTickets: const ['d'],
                                            walletID: walledID,
                                            pass: 0,
                                            stations: const [],
                                            date: const [],
                                            status: const [],
                                          )));
                                }
                              } on FirebaseAuthException {
                                const snackBar = SnackBar(
                                  content: Text('Email is already in use'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } catch (e) {
                                const snackBar = SnackBar(
                                  content: Text('Something went wrong'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ),

                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
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
}
