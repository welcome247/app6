import 'package:flutter/cupertino.dart';
 
class modelX {
  String id = '';
  double a = 0;
  double b = 0;

  modelX({
    String id = '',
    double a = 0,
    double b = 0,
  }) {
    this.id = id;
    this.a = a;
    this.b = b;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'a': a,
      'b': b,
    };
  }
}


class modelB{     

  double beam = 0;   // beam long

//constructer
    inputB({ 
    double beam = 0,
  }) {
    this.beam = beam;
     
  }
}
