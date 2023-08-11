import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model.dart';

class UserInput extends StatefulWidget {
  final ModelBeam beam;

//construter
  UserInput({required this.beam, Key? key}) : super(key: key);

  @override
  UserInputState createState() => UserInputState();
}

List<String> Inputs = [
  'B0',
  'W1',
  'W2',
  'W3',
  'P1',
  'P2',
  'P3',
  'P4',
  'P5',
  'P6',
  'P7',
  'P8'
];

class UserInputState extends State<UserInput> {
  TextEditingController _controllerA =
      TextEditingController(text: '0.0'); //b value textbox
  TextEditingController _controllerB =
      TextEditingController(text: '0.0'); //a value textbox

  String _labelA = '';
  String _labelB = '';
  int _currentIndex = -1;
  String _currentTitle = 'ความยาวคาน';
  String _currentTopic = 'B';
  bool _endOfInput = false;
  double _beamWidth = 0;
  String? _errorText = null;
  double _minA = 0.1; //expect value for box a
  double _maxA = 12; //expect value for box a

  @override
  void initState() {
    reset();
  }

  void reset() {
    setState(() {
      _labelA = '';
      _labelB = '';
      _currentIndex = 0;
      _currentTitle = 'ความยาวคาน';
      _currentTopic = 'B';
      _endOfInput = false;
      _beamWidth = 5; // default
      _errorText = null;
      _minA = 0.1;
      _maxA = 12;
      _controllerA.text = _beamWidth.toStringAsFixed(1);
    });
  }

  @override
  void dispose() {
    _controllerA.dispose();
    _controllerB.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Center(
            child: Column(children: [
//--------------------------------------------------------------------------------------
//#region  Display

          //beam---------------------------------------------------
          SizedBox(height: 20),
          if (widget.beam.beam != 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ความยาวคาน',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: Column(),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(widget.beam.beam.toStringAsFixed(1),
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 0.1,
                ),
              ],
            ),

          //  W ----------------------------------------------------
          for (var x in widget.beam.w)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  //------------------------------------------------------------------
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(x.id.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  )),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.beam.labelW['labelA'].toString()),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(x.a.toStringAsFixed(1),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  )),
                ]),
                Row(children: [
                  //------------------------------------------------------------------
                  const Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  )),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.beam.labelW['labelB'].toString()),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(x.b.toStringAsFixed(1)),
                    ],
                  )),
                ]),
                const Divider(
                  //------------------------------------------------------------------
                  color: Colors.black, // Customize the color of the line
                  thickness: 0.1, // Customize the thickness of the line
                ),
              ],
            ),

          //  P -----------------------------------------------------
          for (var x in widget.beam.p)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  //------------------------------------------------------------------
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(x.id.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  )),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.beam.labelP['labelA'].toString()),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(x.a.toStringAsFixed(1),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  )),
                ]),
                Row(children: [
                  //------------------------------------------------------------------
                  const Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  )),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.beam.labelP['labelB'].toString()),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(x.b.toStringAsFixed(1)),
                    ],
                  )),
                ]),
                const Divider(
                  //------------------------------------------------------------------
                  color: Colors.black, // Customize the color of the line
                  thickness: 0.1, // Customize the thickness of the line
                ),
              ],
            ),

//#endregion
//--------------------------------------------------------------------------------------

          Column(children: [
            if (!_endOfInput)
              Container(
                  padding: EdgeInsets.all(16.0), // 80% of screen width
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.yellow, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(children: [
                     // a -------------------------------------------------------------------------------------------------
                    if (_currentTopic != 'B')
                      Padding(
                          padding:
                              EdgeInsets.all(2.0), // Add padding around the Row
                          child: Row(children: [
                                                      Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_currentTitle,
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ],
                          )),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_labelB),
                              ],
                            )),
                            Expanded(

                                //textfield   -------------------------------------------------------
                                child: TextField(
                              controller: _controllerB,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              textAlign: TextAlign.right,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,1}')),
                              ],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              style: TextStyle(fontSize: 15),
                            ) //textfield-------------------------------------------------------
                                ),
                            // )
                          ])),

                    // b -------------------------------------------------------------------------------------------------
                    Padding(
                        padding:
                            EdgeInsets.all(2.0), // Add padding around the Row
                        child: Row(children: [
                         
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                               if (_currentTopic  == 'B')
                              Text(_currentTitle,
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ],
                          )),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_labelA),
                            ],
                          )),
                          Expanded(

                              //textfield    -------------------------------------------------------
                              child: TextFormField(
                                  controller: _controllerA,
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  textAlign: TextAlign.right,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d{0,1}')),
                                  ],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    errorText: _errorText,
                                  ),
                                  style: TextStyle(fontSize: 15),
                                  onChanged: (String text) {
                                    final value = double.tryParse(text) ?? 0;
                                    if (!(value >= _minA && value <= _maxA)) {
                                      setState(() {
                                        _errorText = 'invalid value';
                                      });
                                    } else {
                                      setState(() {
                                        _errorText = null;
                                      });
                                    }
                                  }) //textfield -------------------------------------------------------
                              ),
                          //  )
                        ])),
                  
                   
                    Row(
                      //button next
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: goNext,
                          child: Text('Next'),
                        )
                      ],
                    )
                  ]))
          ])
//--------------------------------------------------------------------------------------
        ])));
  }

  void goNext() async {
    double valueA = double.tryParse(_controllerA.text) ?? 0;
    double valueB = double.tryParse(_controllerB.text) ?? 0;

    //valueB = valueB.clamp(10, 1000);

    //validate value-----------------------------------

    if (_errorText != null) {
      return;
    }

    //next input--------------------------------------

    // start
    if (_currentIndex == -1) {
      _controllerA.text = _beamWidth.toStringAsFixed(1);
      _currentIndex = 0;
    } //  beam
    else if (_currentIndex == 0) {
      valueA = valueA.clamp(0.1, 12);
      if (valueA == 0) {
        _controllerA.text = _beamWidth.toStringAsFixed(1);
        _currentIndex = 0;
      } else {
        _beamWidth = valueA;
        widget.beam.beam = valueA;

        //for next
        _minA = 0.1;
        _maxA = _beamWidth;
        _currentIndex = 1; // goto first w
        _controllerA.text = valueA.toStringAsFixed(1);
        _controllerB.text = '0.0';
      }
    }
    //w p
    else {
      if (valueA == 0) {
        switch (_currentTopic) {
          case 'W':
            // goto first p
            _currentIndex = 4;
            _minA = 0;
            _maxA = _beamWidth;
            _controllerA.text = _maxA.toStringAsFixed(1);
            _controllerB.text = '0.0';

            break;
          case 'P':
            _endOfInput = true;
            break;
        }
      } else {
        switch (_currentTopic) {
          case 'W':

            //add to list
            widget.beam.w.add(ModelX(id: _currentTitle, a: valueA, b: valueB));

            //for next w
            final double sumOfWidth =
                widget.beam.w.fold(0, (sum, item) => sum + item.a);
            _minA = 0;
            _maxA = _beamWidth - sumOfWidth;
            _currentIndex++;
            _controllerA.text = _maxA.toStringAsFixed(1);
            _controllerB.text = '0.0';

            if (_maxA == 0) {
              // goto first p
              _currentIndex = 4;
              _minA = 0;
              _maxA = _beamWidth;
              _controllerA.text = _maxA.toStringAsFixed(1);
              _controllerB.text = '0.0';
            }

            break;

          case 'P':

            //add to list
            widget.beam.p.add(ModelX(id: _currentTitle, a: valueA, b: valueB));

            //for next w
            final double sumOfWidth =
                widget.beam.p.fold(0, (sum, item) => sum + item.a);
            _minA = 0;
            _maxA = _beamWidth - sumOfWidth;
            _currentIndex++;
            _controllerA.text = _maxA.toStringAsFixed(1);
            _controllerB.text = '0.0';

            if (_maxA == 0 || _currentIndex > Inputs.length - 1) {
              _endOfInput = true;
            }

            break;
        }
      }
    }

    //label------------------------------------------------------------
    _currentTitle = Inputs[_currentIndex];
    _currentTopic = _currentTitle.substring(0, 1);

    if (_currentTitle == 'B0') {
      _currentTitle = 'ความยาวคาน';
    }

    switch (_currentTopic) {
      case 'B':
        _labelA = '';
        _labelB = '';
        break;
      case 'W':
        _labelA = widget.beam.labelW['labelA'].toString();
        _labelB = widget.beam.labelW['labelB'].toString();
        break;
      case 'P':
        _labelA = widget.beam.labelP['labelA'].toString();
        _labelB = widget.beam.labelP['labelB'].toString();
        break;
    }

    //update------------------------------------------------------------
    setState(() {});
  }
}
