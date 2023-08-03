 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 

import 'model.dart';

//beam
class InputB extends StatefulWidget {

  modelB beam;

  //constructer 
  InputB({required this.beam}) {}
 
  @override
  InputBState createState() => InputBState();
}

class InputBState extends State<InputB> {

  //double beam = 0.0;

    @override
  void initState() {
    super.initState();
    //beam = widget.beam; // Initialize beam with the initial value of widget.beam
  }

  final Map<String, dynamic> Properties = {
    'label': 'ความยาวคาน',
  };
  
  
  
  //constructer
  InputBState() {}

  void incrementvalueA() {
    setState(() {
     (widget.beam.beam  += 0.1).clamp(0.0, 99);
    });
  }

  void decrementvalueA() {
    setState(() {
     (widget.beam.beam   -= 0.1).clamp(0.0, 99);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9, // 80% of screen width
      // color: Colors.blue, // Replace with your widget here
      child: Center(
        child: Column(
          children: [
            //b---------------------------------------------------

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Properties['label'],
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () => decrementvalueA(),
                              ),
                              Container(
                                  width: 60.0,

                                  //textfield------------------------------------------------------------------------------------------------------------
                                  child: TextField(
                                    controller: TextEditingController(
                                        text: widget.beam.beam.toStringAsFixed(1)),
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d*\.?\d{0,1}')),
                                    ],
                                    onChanged: (String text) {
                                      // Do something with the updated text value
                                      widget.beam.beam = double.tryParse(text) ?? 0;
                                    },
                                  )

                                  //textfield------------------------------------------------------------------------------------------------------------

                                  ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () => incrementvalueA(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//W
class InputX extends StatefulWidget {
  final String Prefix;
  final List<modelX> Data;

  //construter
  InputX({required this.Prefix, required this.Data});

  @override
  InputXState createState() => InputXState();
}

class InputXState extends State<InputX> {
  Map<String, dynamic> Properties = {};

  bool get canAddInput => widget.Data.length < Properties['max'];

  @override
  void initState() {
    super.initState();

    if (widget.Prefix == 'W') {
      Properties = {
        'max': 3,
        'labelA': 'แรงกระจาย',
        'labelB': 'ความยาวของแรง',
        'button': 'เพิ่ม W',
        'defA': 200.0,
        'defB': 1.0,
      };
    } else if (widget.Prefix == 'P') {
      Properties = {
        'max': 8,
        'labelA': 'แรงแนวดิ่ง',
        'labelB': 'ระยะจากจุดรองรับ',
        'button': 'เพิ่ม P',
        'defA': 200.0,
        'defB': 1.0,
      };
    }

    //   initial for first item
    widget.Data.add(modelX(
        id: widget.Prefix + '1', a: Properties['defA'], b: Properties['defB']));
  }

  void incrementvalueA(int i) {
    setState(() {
      (widget.Data[i].a += 10).clamp(0.0, 1000);
    });
  }

  void decrementvalueA(int i) {
    setState(() {
      (widget.Data[i].a -= 10).clamp(0.0, 1000);
    });
  }

  void incrementvalueB(int i) {
    setState(() {
      (widget.Data[i].b += 0.1).clamp(0.0, 99);
    });
  }

  void decrementvalueB(int i) {
    setState(() {
      (widget.Data[i].b -= 0.1).clamp(0.0, 99);
    });
  }

  void addInput() {
    if (canAddInput) {
      setState(() {
        String id = widget.Prefix + (widget.Data.length + 1).toString();
        widget.Data.add(
            modelX(id: id, a: Properties['defA'], b: Properties['defB']));
      });
    }
  }

  void removeInput(int index) {
    if (widget.Data.length > 1) {
      setState(() {
        widget.Data.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9, // 80% of screen width
      // color: Colors.blue, // Replace with your widget here
      child: Center(
        child: Column(
          children: [
            //w---------------------------------------------------
            for (int i = 0; i < widget.Data.length; i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.Prefix + (i + 1).toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () => removeInput(i),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Properties['labelA']),
                            SizedBox(height: 8),
                            Text(Properties['labelB']),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () => decrementvalueA(i),
                                ),
                                Container(
                                    width: 60.0,

                                    //textfield------------------------------------------------------------------------------------------------------------
                                    child: TextField(
                                      controller: TextEditingController(
                                          text: widget.Data[i].a
                                              .toStringAsFixed(1)),
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d*\.?\d{0,1}')),
                                      ],
                                      onChanged: (String text) {
                                        // Do something with the updated text value
                                        widget.Data[i].a =
                                            double.tryParse(text) ?? 0;
                                      },
                                    )

                                    //textfield------------------------------------------------------------------------------------------------------------

                                    ),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () => incrementvalueA(i),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () => decrementvalueB(i),
                                ),
                                Container(
                                    width: 60.0,
                                    //textfield------------------------------------------------------------------------------------------------------------
                                    child: TextField(
                                      controller: TextEditingController(
                                          text: widget.Data[i].b
                                              .toStringAsFixed(1)),
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d*\.?\d{0,1}')),
                                      ],
                                      onChanged: (String text) {
                                        // Do something with the updated text value
                                        widget.Data[i].b =
                                            double.tryParse(text) ?? 0;
                                      },
                                    )

                                    //textfield------------------------------------------------------------------------------------------------------------
                                    ),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () => incrementvalueB(i),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 20),
                ],
              ),
            ElevatedButton(
              onPressed: addInput,
              child: Text(Properties['button']),
            ),
          ],
        ),
      ),
    );
  }
}
