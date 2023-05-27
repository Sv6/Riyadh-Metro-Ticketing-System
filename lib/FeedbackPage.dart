import 'package:flutter/material.dart';
import "crud.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(FeedbackPage());
}

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  final _formKey = GlobalKey<FormState>();

  final Crud CRUD = Crud();
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;

  @override
  void initState() {
    // TODO: implement initState
    _titleController = TextEditingController();
    _bodyController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 6, 179, 107),
        title: Text('Feedback'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.0),
              TextFormField(
                controller: _titleController,
                validator: (value) {
                  if (_titleController.text.isEmpty) {
                    return "Title cannot be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _bodyController,
                validator: (value) {
                  if (_bodyController.text.isEmpty) {
                    return "Body cannot be empty";
                  }
                  return null;
                },
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Let us what you think',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  String id = await CRUD.getId();
                  if (_formKey.currentState!.validate()) {
                    CRUD.insertFeedback(
                        _titleController.text, _bodyController.text, id);
                    _titleController.clear();
                    _bodyController.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 6, 179, 107)),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
