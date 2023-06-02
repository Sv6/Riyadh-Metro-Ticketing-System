import 'package:flutter/material.dart';

import 'Admin.dart';
import 'validator.dart';
import 'crud.dart';

void main() {
  runApp(UpdateAdminProfile());
}

class UpdateAdminProfile extends StatelessWidget {
  const UpdateAdminProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'update admin',
      home: UpdateAdminProfilePage(),
    );
  }
}

class UpdateAdminProfilePage extends StatefulWidget {
  const UpdateAdminProfilePage({super.key});

  @override
  _UpdateAdminProfilePageState createState() => _UpdateAdminProfilePageState();
}

class _UpdateAdminProfilePageState extends State<UpdateAdminProfilePage> {
  bool hidePass = true;
  final _formKey = GlobalKey<FormState>();
  final Validator validate = Validator();
  final Crud CRUD = Crud();
  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Update Profile'),
          backgroundColor: Color.fromARGB(255, 6, 179, 107),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => (Admin())));
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return null;
                    } else if (!validate.validateName(
                        name: _fullNameController.text)) {
                      return "enter a valid name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return null;
                    } else if (!validate.validatePassword(
                        password: _passwordController.text)) {
                      return "6+ chars, 1 uppercase, 1 lowercase, 1 digit required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          hidePass = !hidePass;
                        });
                      },
                      child: Icon(
                          hidePass ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                  obscureText: hidePass,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      labelText: 'Email', prefixIcon: Icon(Icons.email)),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return null;
                    } else if (!validate.validateEmail(
                        email: _emailController.text)) {
                      return "enter a valid email";
                    } else if (!validate.isAdmin(_emailController.text)) {
                      return "email must end with @metro.com";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return null;
                    } else if (!validate.validatePhone(
                        phone: _phoneNumberController.text)) {
                      return "phone number not valid (05xxxxxxxx)";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.0),
                SizedBox(
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_fullNameController.text.isNotEmpty ||
                            _passwordController.text.isNotEmpty ||
                            _emailController.text.isNotEmpty ||
                            _phoneNumberController.text.isNotEmpty) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text("Information Updated"),
                              content: Text(
                                  "The information has been successfully updated. Your changes have been saved."),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK")),
                              ],
                            ),
                          );
                        } else {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text("All fields are empty"),
                              content:
                                  Text("Fill the fields you want to update"),
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

                        if (_fullNameController.text.isNotEmpty) {
                          CRUD.updateAdminName(_fullNameController.text);
                          _fullNameController.clear();
                        }
                        if (_passwordController.text.isNotEmpty) {
                          CRUD.updateAdminPassword(_passwordController.text);
                          _passwordController.clear();
                        }
                        if (_emailController.text.isNotEmpty) {
                          CRUD.updateAdminEmail(_emailController.text);
                          _emailController.clear();
                        }
                        if (_phoneNumberController.text.isNotEmpty) {
                          CRUD.updateAdminPhone(_phoneNumberController.text);
                          _phoneNumberController.clear();
                        }
                        
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 6, 179, 107),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Update',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
