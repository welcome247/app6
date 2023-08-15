import 'package:flutter/material.dart';

import 'model.dart';

 

class DrawA extends StatelessWidget { 

  final ModelBeam _beam;
  
 //constructer
 DrawA( this._beam  ){}
 
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
                painter: CanvasPainter(1, _beam ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CanvasPainter extends CustomPainter {
  final double _scale;

 final ModelBeam _beam;

   //constructer
  CanvasPainter(this._scale ,this._beam );
 
// format
  final List Wf = [
    {'strock': Colors.green, 'fill': Colors.green[50],  },
    {'strock': Colors.blue, 'fill': Colors.blue[50],  },
    {'strock': Colors.purple, 'fill': Colors.purple[50],  },
  ];
 
  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(_scale, _scale); // Apply the scaling factor

    double MXPX = size.width; // max width pixel on screen
    double factW = MXPX / _beam.beam; //width factor
    double factH = size.height / 8; //height factor
    double stroke = 2;

    var paintx = Paint();
    var paintf = Paint();

final _high = 1.5;
    final BL = factH * 5; //baseline
    double x1 = 0;
    double Width = 0;

// draw W -----------------------------------------------------------------------------

    for (var i = 0; i <= _beam.w.length - 1; i++) {
      //set brush
      paintx = new Paint()
        ..color = Wf[i]['strock']
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke;

      paintf = new Paint()
        ..color = Wf[i]['fill']
        ..style = PaintingStyle.fill;

     Width =_beam.w[i].a*factW; 

      final high = ((_high * factH));
      final rect = Rect.fromLTWH(x1, BL - high, Width - stroke, high);

      //draw
      canvas.drawRect(rect, paintf);
      canvas.drawRect(rect, paintx);

      //text
      final textPainterA = TextPainter(
          text: TextSpan(
            text: _beam.w[i].id.toString(),
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
            text: _beam.w[i].b.toString(),
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

    final Y1 = BL - (1.6 * factH);
    final Y2 = BL - (2.5 * factH);
    double X = 0;

    for (var i = 0; i <= _beam.p.length - 1; i++) {
      X +=_beam.p[i].a * factW;

      canvas.drawLine(Offset(X, Y1), Offset(X, Y2), paintx);

      //arrow head
      var path = Path();
      path.moveTo(X, Y1 + 6);
      path.lineTo(X - 5, Y1);
      path.lineTo(X + 5, Y1);
      path.close();
      canvas.drawPath(path, paintx);

//text
      final textPainterA = TextPainter(
          text: TextSpan(
            text: _beam.p[i].id.toString(),
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
            text: _beam.p[i].b.toStringAsFixed(0),
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

    for (var i in _beam.p) {
      final width = i.a;
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
      textPainterA.paint(canvas, Offset(X - ((i.a * factW) / 2), PY1 - 10));
    }

// W mark

    final WY1 = BL + (1 * factH);
    final WY2 = WY1 + 10;

    X = 0;
    canvas.drawLine(Offset(X, WY1), Offset(X, WY2), paintx);

    for (var i in _beam.w) {
      final width = i.a;
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
      textPainterA.paint(canvas, Offset(X - ((i.a * factW) / 2), WY1 - 10));
    }

    // max mark
    canvas.drawLine(Offset(0, WY1 + 30), Offset(MXPX, WY1 + 30), paintx);
    canvas.drawLine(Offset(0, WY1 + 25), Offset(0, WY1 + 35), paintx);
    canvas.drawLine(Offset(MXPX, WY1 + 25), Offset(MXPX, WY1 + 35), paintx);

    final textPainterA = TextPainter(
        text: TextSpan(
          text: _beam.beam.toStringAsFixed(1) ,
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


