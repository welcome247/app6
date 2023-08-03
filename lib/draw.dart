import 'package:flutter/material.dart';

import 'model.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Canvas')),
//         body: MyCanvas(),
//       ),
//     );
//   }
// }

// class draw extends StatefulWidget {
//   @override
//   drawState createState() => drawState();
// }

class drawA extends StatelessWidget { 

  final modelB Beam;
  final List<modelX> W;
  final List<modelX> P;
 
 //constructer
 drawA( this.Beam,this.W,this.P ){}

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Canvas'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              // use container to difine canvas in percentage and center of screen
              width: screenWidth * 0.8,
              height: screenHeight * 0.8,
              color: Colors.orange[50],
              child: CustomPaint(
                size: Size(double.infinity, double.infinity),
                painter: CanvasPainter(1, Beam, W, P ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CanvasPainter extends CustomPainter {
  final double scale;

  final modelB Beam;
  final List<modelX> W;
  final List<modelX> P;

   //constructer
  CanvasPainter(this.scale ,this.Beam,this.W,this.P);

  //input form user ------------------------------------------------------------------

  //double beam = 5;// beam ; // max width
 
  // List W = [
  //   {'id': 'W1', 'b': 1.8, 'a': 600},
  //   {'id': 'W2', 'b': 2.5, 'a': 1100},
  //   {'id': 'W3', 'b': 1.2, 'a': 400},
  // ];

  // List P = [
  //   {'id': 'P1', 'b': 1.8, 'a': 200},
  //   {'id': 'P2', 'b': 3.1, 'a': 500},
  // ];

// format
  final List Wf = [
    {'strock': Colors.green, 'fill': Colors.green[50], 'high': 1},
    {'strock': Colors.blue, 'fill': Colors.blue[50], 'high': 1.2},
    {'strock': Colors.purple, 'fill': Colors.purple[50], 'high': 1.4},
  ];

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(scale, scale); // Apply the scaling factor

    double MXPX = size.width; // max width pixel on screen
    double factW = MXPX / Beam.beam; //width factor
    double factH = size.height / 8; //height factor
    double stroke = 2;

    var paintx = Paint();
    var paintf = Paint();

    final BL = factH * 5; //baseline
    double x1 = 0;
    double Width = 0;

// draw W -----------------------------------------------------------------------------

    for (var i = 0; i <= W.length - 1; i++) {
      //set brush
      paintx = new Paint()
        ..color = Wf[i]['strock']
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke;

      paintf = new Paint()
        ..color = Wf[i]['fill']
        ..style = PaintingStyle.fill;

     Width =W[i].b*factW; 

      final high = ((Wf[i]['high'] * factH));
      final rect = Rect.fromLTWH(x1, BL - high, Width - stroke, high);

      //draw
      canvas.drawRect(rect, paintf);
      canvas.drawRect(rect, paintx);

      //text
      final textPainterA = TextPainter(
          text: TextSpan(
            text: W[i].id.toString(),
            style: TextStyle(
              color: Wf[i]['strock'],
              fontSize: 15,
            ),
          ),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center);
      textPainterA.layout();

      final textPainterB = TextPainter(
          text: TextSpan(
            text: W[i].a.toString(),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center);
      textPainterB.layout();

      textPainterA.paint(canvas, Offset(x1 + 4, BL - high + 4));
      textPainterB.paint(canvas, Offset(x1 + 4, BL - high + 22));

      //sum of box
      x1 += (Width);
    }

// draw P -----------------------------------------------------------------------------
    paintx = new Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final Y1 = BL - (1.7 * factH);
    final Y2 = BL - (2.4 * factH);
    double X = 0;

    for (var i = 0; i <= P.length - 1; i++) {
      X += P[i].b * factW;

      canvas.drawLine(Offset(X, Y1), Offset(X, Y2), paintx);

      var path = Path();
      path.moveTo(X, Y1 + 6);
      path.lineTo(X - 5, Y1);
      path.lineTo(X + 5, Y1);
      path.close();
      canvas.drawPath(path, paintx);

//text
      final textPainterA = TextPainter(
          text: TextSpan(
            text: P[i].id.toString(),
            style: TextStyle(
              color: Colors.pink,
              fontSize: 15,
            ),
          ),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center);
      textPainterA.layout();

      final textPainterB = TextPainter(
          text: TextSpan(
            text: P[i].a.toStringAsFixed(0),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center);
      textPainterB.layout();

      textPainterA.paint(canvas, Offset(X + 2, Y2));
      textPainterB.paint(canvas, Offset(X + 2, Y2 + 18));
    }

// draw Base -----------------------------------------------------------------------------

    paintx = new Paint()
      ..color = Colors.blue.shade900
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

//base line
    canvas.drawLine(Offset(0, BL), Offset(MXPX, BL), paintx);

//triangle
    var path = Path();
    path.moveTo(0, BL);
    path.lineTo(10, BL + 20);
    path.lineTo(-10, BL + 20);
    path.close();
    canvas.drawPath(path, paintx);

//circle
    canvas.drawCircle(Offset(MXPX, BL + 10), 10, paintx);

// draw Mark -----------------------------------------------------------------------------

    paintx = new Paint()
      ..color = Colors.grey.shade900
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
//P mark
    final PY1 = BL - (2.8 * factH);
    final PY2 = PY1 + 10;
    X = 0;
    canvas.drawLine(Offset(X, PY1), Offset(X, PY2), paintx);

    for (var i in P) {
      final width = i.b;
      X += (width * factW);

      canvas.drawLine(Offset(X, PY1), Offset(X, PY2), paintx);
      canvas.drawLine(Offset(0, PY1 + 5), Offset(X, PY1 + 5), paintx); 
      //text
      final textPainterA = TextPainter(
          text: TextSpan(
            text: width.toStringAsFixed(1),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center);
      textPainterA.layout();
      textPainterA.paint(canvas, Offset(X - ((i.b * factW) / 2), PY1 - 10));
    }

// W mark

    final WY1 = BL + (1 * factH);
    final WY2 = WY1 + 10;

    X = 0;
    canvas.drawLine(Offset(X, WY1), Offset(X, WY2), paintx);

    for (var i in W) {
      final width = i.b;
      X += (width * factW);

      canvas.drawLine(Offset(X, WY1), Offset(X, WY2), paintx);
      canvas.drawLine(Offset(0, WY1 + 5), Offset(X, WY1 + 5), paintx);
      //text
      final textPainterA = TextPainter(
          text: TextSpan(
            text: width.toStringAsFixed(1),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center);
      textPainterA.layout();
      textPainterA.paint(canvas, Offset(X - ((i.b * factW) / 2), WY1 - 10));
    }

    // max mark
    canvas.drawLine(Offset(0, WY1 + 30), Offset(MXPX, WY1 + 30), paintx);
    canvas.drawLine(Offset(0, WY1 + 25), Offset(0, WY1 + 35), paintx);
    canvas.drawLine(Offset(MXPX, WY1 + 25), Offset(MXPX, WY1 + 35), paintx);

    final textPainterA = TextPainter(
        text: TextSpan(
          text: Beam.beam.toStringAsFixed(1) ,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.right);
    textPainterA.layout();
    textPainterA.paint(canvas, Offset(  (MXPX / 2), WY1 + 15));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


