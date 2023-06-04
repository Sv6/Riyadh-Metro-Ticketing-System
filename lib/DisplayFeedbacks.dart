
import 'package:flutter/material.dart';
import 'crud.dart';
import 'Admin.dart';

void main() {
  runApp(DisplayFeedback());
}

class DisplayFeedback extends StatefulWidget {
  const DisplayFeedback({super.key});

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
        '/details': (context) => FeedbackDetailsPage(
              title: "",
              body: "",
              name: "",
              time: "",
              uid: "",
              id: "",
            ),
      },
    );
  }
}

class FeedbackListPage extends StatefulWidget {
  const FeedbackListPage({super.key});

  @override
  State<FeedbackListPage> createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  Crud CRUD = Crud();

  List<dynamic> feedbackList = [];
  List ids = [];

  @override
  void initState() {
    List<dynamic> feedbackList;
    List ids;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedbacks'),
        backgroundColor: Color.fromARGB(255, 6, 179, 107),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Admin(), fullscreenDialog: true))
                .then((_) => Navigator.pop(context));
          },
        ),
      ),
      body: FutureBuilder(
        future: Future.wait([CRUD.getFeedbackNameId()]),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            Map<String, String> data = snapshot.data[0] as Map<String, String>;

            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              setState(() {
                feedbackList = data.values.toList();
                ids = data.keys.toList();
              });
            });
          } else {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            itemCount: feedbackList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(feedbackList[index]),
                onTap: () async {
                  Map<String, dynamic> feedback =
                      await CRUD.getFeedbackInfo(ids[index]);
                  Map<String, dynamic> user =
                      await CRUD.getUserData(feedback["ID"]);

                  if (context.mounted) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FeedbackDetailsPage(
                              title: feedbackList[index],
                              body: feedback["BODY"],
                              name: user["FULLNAME"].toString(),
                              time: feedback["DATE"].toString(),
                              uid: feedback["ID"],
                              id: ids[index],
                            )));
                  }
                },
              );
            },
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey,
              height: 1,
            ),
          );
        },
      ),
    );
  }
}

class FeedbackDetailsPage extends StatefulWidget {
  final String title;
  final String body;
  final String name;
  final String time;
  final String uid;
  final String id;

  const FeedbackDetailsPage(
      {super.key,
      required this.title,
      required this.body,
      required this.name,
      required this.time,
      required this.uid,
      required this.id});

  @override
  State<FeedbackDetailsPage> createState() => _FeedbackDetailsPageState();
}

class _FeedbackDetailsPageState extends State<FeedbackDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color.fromARGB(255, 6, 179, 107),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    runAlignment: WrapAlignment.spaceBetween,
                    spacing: 10.0, 
                    direction: Axis.horizontal,
                    children: [
                      Text("Name: ${widget.name}"),
                      Text("Time: ${widget.time}"),
                    ],
                  ),
                ),
                Text(
                  "ID: #${widget.uid}",
                ),
                Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.body),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                 
                  width: 150.0,
                  height: 50.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () async {
                      Crud CRUD = Crud();
                      CRUD.removeFeedback(widget.id);
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => DisplayFeedback()))
                          .then((_) => Navigator.pop(context));
                    },
                    child: Text(
                      'COMPLETE',
                      style: TextStyle(fontSize: 18.0),
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
