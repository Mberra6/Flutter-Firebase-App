// ignore_for_file: prefer_const_constructors
//import 'dart:js';



//import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}



// Conectar a Firebase
class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: _fbApp,
        builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
          WidgetsFlutterBinding.ensureInitialized();
          if (snapshot.hasError) {
            print('You have an error! ${snapshot.error.toString()}');
            return Text('Something went wrong!');
          } else if (snapshot.hasData) {
            return Home();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}




class Home extends StatelessWidget {
  final database = FirebaseDatabase.instance.reference();
  final String brand = 'Brand';

  Future createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Enter Barrel capacity'),
        content: TextField(
          controller: customController,
        ),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text('Submit'),
            onPressed: () {
              Navigator.of(context).pop(customController.text.toString());
            },
          )
        ],
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
              'BARREL BROS',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: Colors.deepOrange,
                fontFamily: 'Anton',
              )
          ),
          centerTitle: true,
          backgroundColor: Colors.black87,
          actions: [
            Icon(
              Icons.clear_all_rounded,
              size: 40.0,
              color: Colors.deepOrange,
            ),
          ],
        ),
        body: Builder(builder: (context) {
          return ListView(
            children: [
              const SizedBox(height: 16),
              buildFirst(),
              const SizedBox(height: 16),
              buildSecond(),
              const SizedBox(height: 16),
              buildThird(),
              const SizedBox(height: 16),
              buildFourth(),

              //const SizedBox(height: 100),
              //buildAlert(),
            ],

          );
        }
        ),
        backgroundColor: Colors.black87,
      ),
    );
  }

  // First row
  Widget buildFirst() {
    return Container(
      padding: EdgeInsets.all(24),
      width: double.infinity,
      height: 125,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.deepOrange,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Brand',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 8),
              StreamBuilder(
                  stream: database
                      .child('UsersData/hTpvnDhdk3cbe8bePGzkjWJaol73/readings')
                      .orderByKey()
                      .limitToLast(1)
                      .onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      String volume = '';
                      final reading = Map<String, dynamic>.from(
                          snapshot.data!.snapshot.value as Map<dynamic,
                              dynamic>);
                      reading.forEach((key, value) {
                        final next = Map<String, dynamic>.from(value);
                        volume = next['Volume'];
                      });
                      final double vol_to_double = double.parse(volume);
                      int pints = (vol_to_double / 500).round();
                      return Text(
                        'Remaining Pints: $pints',
                        style: TextStyle(
                          fontSize: 20.0,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }
              )

            ],

          ),
          const SizedBox(width: 65),
          Row(
            children: [
              // Display Data from Firebase
              StreamBuilder(
                  stream: database
                      .child('UsersData/hTpvnDhdk3cbe8bePGzkjWJaol73/readings')
                      .orderByKey()
                      .limitToLast(1)
                      .onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      String volume = '';

                      final reading = Map<String, dynamic>.from(
                          snapshot.data!.snapshot.value as Map<dynamic,
                              dynamic>);
                      reading.forEach((key, value) {
                        final next = Map<String, dynamic>.from(value);
                        volume = next['Volume'];
                      });
                      final double vol_to_double = double.parse(volume);
                      int percentage = (((vol_to_double / 1000) * 100) / 40)
                          .round();
                      return Text(
                        '${percentage}%',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }
              )
            ],
          ),
        ],
      ),
    );
  }

  // Second row
  Widget buildSecond() {
    return Container(
      padding: EdgeInsets.all(24),
      width: double.infinity,
      height: 125,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.deepOrange,
      ),
      child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Brand',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Remaining Pints: ',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 65),
            Row(
              children: [
                Text(
                    '100%',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    )
                )
              ],
            )

          ]
      ),

    );
  }

  // Third row
  Widget buildThird() {
    return Container(
      padding: EdgeInsets.all(24),
      width: double.infinity,
      height: 125,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.deepOrange,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Brand',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Remaining Pints: ',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  letterSpacing: 2.0,
                ),
              ),

            ],

          ),
          const SizedBox(width: 65),
          Row(
            children: [
              Text(
                  '100%',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  )
              )
            ],
          ),
        ],
      ),
    );
  }

  // Fourth row
  Widget buildFourth() {
    return Container(
      padding: EdgeInsets.all(24),
      width: double.infinity,
      height: 125,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.deepOrange,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Brand',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Remaining Pints: ',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  letterSpacing: 2.0,
                ),
              ),

            ],

          ),
          const SizedBox(width: 65),
          Row(
            children: [
              Text(
                  '100%',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  )
              )
            ],
          ),
        ],
      ),
    );
  }
}



