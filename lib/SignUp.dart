import 'package:flutter/material.dart';

import 'login.dart';

void main() {
  runApp(SignUpPage());
}

class SignUpPage extends StatelessWidget {
  @override
  // State<myApp> createState() => _myAppState();

// class _myAppState extends State<myApp> {
  bool hidePass = true;
//   bool hideVerifyPass = true;

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
        body: SingleChildScrollView(
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
                      margin: const EdgeInsets.only(left: 10.0, right: 15.0),
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
                      margin: const EdgeInsets.only(left: 10.0, right: 15.0),
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
                child: TextField(
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
                child: TextField(
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
                child: TextField(
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
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        // setState(() {
                        //   hidePass = !hidePass;
                        // });
                      },
                      child: Icon(
                          hidePass ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  obscureText: hidePass,
                ),
              ),
              // ========================= PASSWORD VERIFICATION =========================
              SizedBox(height: 20.0),
              Container(
                width: 300.0,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        // setState(() {
                        //   hidePass = !hidePass;
                        // });
                      },
                      child: Icon(
                          hidePass ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  obscureText: hidePass,
                ),
              ),
              // ========================= EMAIL =========================
              SizedBox(height: 20.0),
              Container(
                width: 300.0,
                child: TextField(
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
                child: TextField(
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
                  onPressed: () {},
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
        ),
      ),
    );
  }
}
