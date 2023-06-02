import 'package:flutter/material.dart';
import 'package:riyadh_metro/crud.dart';
import 'Admin.dart';

void main() {
  runApp(FreezeAccount());
}

class FreezeAccount extends StatelessWidget {
  const FreezeAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User ID',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FreezeAccountPage(),
    );
  }
}

class FreezeAccountPage extends StatefulWidget {
  const FreezeAccountPage({super.key});

  @override
  _FreezeAccountPageState createState() => _FreezeAccountPageState();
}

class _FreezeAccountPageState extends State<FreezeAccountPage> {
  final TextEditingController _userIdController = TextEditingController();
  Crud CRUD = Crud();

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Freeze Account'),
        backgroundColor: Color.fromARGB(255, 6, 179, 107),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Admin()))
                .then((_) => Navigator.pop(context));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 150.0),
                  Text(
                    'Copy the user ID from Firebase:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _userIdController,
                    decoration: InputDecoration(
                      labelText: 'User ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        
                          if(await CRUD.switchFreezeAccount(_userIdController.text)) {
                            const snackBar = SnackBar(content: Text("Done"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }else {
                            const snackBar = SnackBar(content: Text("Not Found"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                          
                        
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: Color.fromARGB(255, 6, 179, 107),
                          fixedSize: Size(200, 50)),
                      child: Text('Unfreeze/Freeze'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
