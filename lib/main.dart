 

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

 //*all input data from user start here
  modelB beam = modelB() ;
  List<modelX> inpW = [];
  List<modelX> inpP = [];

void initState() {
    super.initState();

     beam.beam = 5;  // default beam long
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Input')),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              InputB(beam:beam),
              Row(children: <Widget>[Expanded(child: Divider())]),

              InputX(Prefix: 'W', Data: inpW   ),
              Row(children: <Widget>[Expanded(child: Divider())]),

              InputX(Prefix: 'P', Data: inpP),
              Row(children: <Widget>[Expanded(child: Divider())]),

              ElevatedButton(
                onPressed: () {
                  submitData(context);
                },
                child: Text('submit'),
              ),
            ]),
          ),
        ));
  }

  void submitData(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => drawA(beam, inpW, inpP), //
      ),
    );
  }
}
 
 