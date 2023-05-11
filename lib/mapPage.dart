import 'package:flutter/material.dart';
import 'package:riyadh_metro/login.dart';

void main() {
  runApp(mapPage());
}

class mapPage extends StatefulWidget {
  @override
  State<mapPage> createState() => _myAppState();
}

class _myAppState extends State<mapPage> {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Map",
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          title: Text('Map'),
          backgroundColor: Color.fromARGB(255, 6, 179, 107),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: GestureDetector(
          onTap: () {
            // Add code to zoom in on the image here
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/map.jpg'),
                // fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
