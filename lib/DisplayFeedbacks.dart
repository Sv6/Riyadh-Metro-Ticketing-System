import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'crud.dart';

void main() {
  runApp(DisplayFeedback());
}

class DisplayFeedback extends StatefulWidget {
  @override
  State<DisplayFeedback> createState() => _DisplayFeedbackState();
}

class _DisplayFeedbackState extends State<DisplayFeedback> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedbacks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FeedbackListPage(),
      routes: {
        '/details': (context) => FeedbackDetailsPage(),
      },
    );
  }
}

class FeedbackListPage extends StatefulWidget {
  @override
  State<FeedbackListPage> createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  Crud CRUD = Crud();

  List<dynamic> feedbackList = ["Press the refresh"];
  List ids = [];
  // Future<Map<String, String>> _method = {};

  @override
  void initState() {
    List<dynamic> feedbackList;
    List ids;
    // _method = CRUD.getFeedbackNameId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Feedbacks'),
          backgroundColor: Color.fromARGB(255, 6, 179, 107),
          actions: [
            IconButton(
                onPressed: () async {
                  Map<String, String> data = await CRUD.getFeedbackNameId();
                  print(data);

                  setState(() {
                    feedbackList = data.values.toList();
                    ids = data.keys.toList();
                  });
                },
                icon: Icon(Icons.refresh)),
          ],
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: 200,
            child: ListView.separated(
              itemCount: feedbackList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(feedbackList[index]),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/details',
                      arguments: feedbackList[index],
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => Divider(
                color: Colors.white,
                height: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FeedbackDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final String feedback = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Details'),
      ),
      body: Center(
        child: Text("gyvhj"),
      ),
    );
  }
}
