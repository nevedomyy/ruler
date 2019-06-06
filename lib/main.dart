import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      home: _Ruler()
    );
  }
}

class _Ruler extends StatelessWidget{
  double _height;
  double _width;

  Widget _numbers(double unit){
    List<Widget> list = List();
    int iter = 0;
    while(2*5*unit*iter <= _width){
      iter++;
      list.add(Positioned(
        top: unit == 5.8 ? 30.0 : _height-60.0,
        left: 2*5*unit*iter-5,
        child: Text(
          iter.toString(),
          style: TextStyle(color: Colors.white, fontSize: 20.0, fontFamily: 'OpenSansCondensed-Light'),
        ),
      ));
    }
    return Stack(
      children: list
    );
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Material(
      color: Color.fromRGBO(49, 51, 53, 1),
      child: Stack(
        children: <Widget>[
          CustomPaint(
            size: Size.infinite,
            painter: _Scale(),
          ),
          Positioned(
            left: 30,
            top: 70,
            child: Text(
              'cm',
              style: TextStyle(color: Colors.white, fontSize: 30.0, fontFamily: 'OpenSansCondensed-Light'),
            ),
          ),
          Positioned(
            left: 30,
            bottom: 70,
            child: Text(
              'inch',
              style: TextStyle(color: Colors.white, fontSize: 30.0, fontFamily: 'OpenSansCondensed-Light'),
            ),
          ),
          _numbers(5.8),
          _numbers(14.7),
          Positioned(
            right: 30,
            top: _height/2-25,
            child: GestureDetector(
              onTap: (){SystemChannels.platform.invokeMethod('SystemNavigator.pop');},
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(45.0))
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(Icons.close, size: 40.0, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Scale extends CustomPainter{

  _lines(Canvas canvas, Size size, double unit){
    final paint1 = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;
    final paint2 = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;
    int iter = 0;
    while(unit*iter <= size.width){
      iter++;
      canvas.drawLine(Offset(unit*iter, unit == 5.8 ? 0 : size.height), Offset(unit*iter, unit == 5.8 ? 19 : size.height-19), paint1);
      if(5*unit*iter <= size.width) canvas.drawLine(Offset(5*unit*iter, unit == 5.8 ? 0 : size.height), Offset(5*unit*iter, unit == 5.8 ? 23 : size.height-23), paint1);
      if(2*5*unit*iter <= size.width) canvas.drawLine(Offset(2*5*unit*iter, unit == 5.8 ? 0 : size.height), Offset(2*5*unit*iter, unit == 5.8 ? 27 : size.height-27), paint2);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = Color.fromRGBO(49, 51, 53, 1));
    _lines(canvas, size, 5.8);
    _lines(canvas, size, 14.7);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}