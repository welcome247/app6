//version 1.0.2

import 'package:flutter/material.dart';
import 'draw.dart';
import 'input.dart';
import 'model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}
 
class HomePageState extends State<HomePage> {
  //*all input  from user collect here
  ModelBeam beam = ModelBeam();

  final GlobalKey<UserInputState> _myWidgetKey = GlobalKey();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Beam Input')),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              // Display(beam: beam ),
              UserInput(beam: beam, key: _myWidgetKey),
            
              // button ------------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              beam.clear();
                              _myWidgetKey.currentState?.reset();
                            });
                          },
                          child: Text('Reset'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueGrey,
                          ))),
                  SizedBox(width: 20),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                        onPressed: () {
                          submitData(context);
                        },
                        child: Text('Submit'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        )),
                  ),
                ],
              )
            ]),
          ),
        ));
  }

  void submitData(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DrawA(beam), //
      ),
    );
  }
}
