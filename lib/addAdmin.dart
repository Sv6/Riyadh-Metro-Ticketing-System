import 'package:flutter/material.dart';
import 'Admin.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'validator.dart';
import 'crud.dart';
import 'package:intl/intl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(addAdmin());
}

class addAdmin extends StatefulWidget {
  const addAdmin({super.key});

  @override
  State<addAdmin> createState() => _addAdminState();
}

class _addAdminState extends State<addAdmin> {
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
      title: 'add Admin Page',
      theme: ThemeData(
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 6, 179, 107),
            ), 
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 6, 179, 107),
            ), 
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
                    height: 15,
                  ),
                  //========================= ADMIN TEXT =========================
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Admin()));
                        },
                        icon: Icon(Icons.arrow_back),
                        color: Color.fromARGB(255, 6, 179, 107),
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
                      Text(
                        'Admin',
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
                    
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_back),
                        color: Color.fromARGB(0, 6, 179, 107),
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
                                 
                                  lastDate: DateTime(2005));

                              if (pickedDate != null) {
                                
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                               
                                setState(() {
                                  _birthDate.text =
                                      formattedDate; 
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
                              if (!validate.isAdmin(value)) {
                                return "Admin must end with @metro.com";
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
                                  if (!CRUD.insertAdmin(
                                    uid,
                                    _name.text,
                                    _birthDate.text,
                                    email,
                                    _phone.text,
                                    _password.text,
                                    true,
                                  )) {
                                    throw Exception("error occured");
                                  }

                                  if (context.mounted) {
                                    showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: Text("Completed"),
                                      content:
                                          Text("Admin added Successfully."),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("OK")),
                                      ],
                                    ),
                                  );
                                  }
                                  
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
                              'Create',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ),

                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  // ========================= SIGN IN =========================
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
