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

  final List<String> feedbackList = [
    'Feedback 1',
    'Feedback 2',
    'Feedback 3',
    'Feedback 4',
    'Feedback 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedbacks'),
        backgroundColor: Color.fromARGB(255, 6, 179, 107),
      ),
      body: ListView.builder(
        itemCount: feedbackList.length,
        itemBuilder: (context, index) {
          return FutureBuilder(
            // future: ,
            builder: (context, snapshot) {
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
            }
          );
        },
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
