import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'crud.dart';
import 'Admin.dart';

void main() => runApp(CancelPage());

class CancelPage extends StatelessWidget {
  const CancelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Canceled Tickets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: myCancelPage(),
    );
  }
}

class myCancelPage extends StatefulWidget {
  const myCancelPage({super.key});

  @override
  _myCancelPage createState() => _myCancelPage();
}

class _myCancelPage extends State<myCancelPage> {
  Crud CRUD = Crud();

  List<dynamic> names = [];
  List ids = [];
  List stations = [];

  @override
  void initState() {
    List<dynamic> names;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Canceled Tickets'),
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
        future: Future.wait([CRUD.getCancelMap()]),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            List<Map<String, dynamic>> data =
                snapshot.data[0] as List<Map<String, dynamic>>;

            List nameTemp = [];

            for (var element in data) {
              nameTemp.add(element.values);
            }

            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              setState(() {
                names = List.from(nameTemp);
              });
            });
            
          } else {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            itemCount: names.length,
            itemBuilder: (context, index) {
              List myData = names[index].toList();
              return ListTile(
                title: Text(myData[3].toString()),
                subtitle: Text(myData[2].toString()),
                trailing: Text(myData[0]),
                // trailing: Text(ids[index]),
                onTap: () async {
                  if (context.mounted) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CancelDetailsPage(
                              id: myData[0], 
                              uid: myData[1], 
                              name: myData[2],
                              station: myData[3],
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

class CancelDetailsPage extends StatefulWidget {
  final String id;
  final String station;
  final String name;
  final String uid;

  const CancelDetailsPage({
    super.key,
    required this.id,
    required this.station,
    required this.name,
    required this.uid,
  });

  @override
  State<CancelDetailsPage> createState() => _FeedbackDetailsPageState();
}

class _FeedbackDetailsPageState extends State<CancelDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id),
        backgroundColor: Color.fromARGB(255, 6, 179, 107),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1)
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text("Name: ${widget.name}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Text(
                        "ID: #${widget.uid}",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Station: ${widget.station}"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                     DottedLine(
                          direction: Axis.horizontal,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 10,
                          dashColor: Colors.grey,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: Colors.transparent,
                          dashGapRadius: 0.0,
                        ),
                    SizedBox(height: 15,),
                    SizedBox(
                      
                      width: 220.0,
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
                          CRUD.Refund(widget.id, widget.uid);
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => CancelPage()))
                              .then((_) => Navigator.pop(context));
                        },
                        child: Text(
                          'Confirm and Refund',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
