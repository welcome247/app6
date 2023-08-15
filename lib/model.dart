class ModelX {
  String id = '';
  double a = 0;
  double b = 0;
 
  ModelX({
    String id = '',
    double a = 0,
    double b = 0,
  }) {
    this.id = id;
    this.a = a;
    this.b = b; 
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'a': a,
  //     'b': b,
  //   };
  // }
}

class ModelBeam {
  double beam = 0; //ความยาวคาน
  List<ModelX> w = [];
  List<ModelX> p = [];

  final Map<String, String> labelW = {
    'title': 'W',
    'labelA': 'ความยาวของแรง',
    'labelB': 'แรงกระจาย'
  };
  final Map<String, String> labelP = {
    'title': 'P',
    'labelA': 'ระยะจากจุดรองรับ',
    'labelB': 'แรงแนวดิ่ง',
  };

  void clear() {
    beam = 0;
    w.clear();
    p.clear();
  }
 
}
