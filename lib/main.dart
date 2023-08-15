//version 1.0.3

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

  //final GlobalKey<UserInputState> _myWidgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Beam Input')),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              // Display(beam: beam ),
              UserInput(
                beam: beam,
                onSubmit:  ()=> submitData(context),
              ),
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
