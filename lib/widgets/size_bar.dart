import 'package:flutter/material.dart';

class MySizeBar extends StatefulWidget {
  double occupiedSize;
  double maxSize;

  MySizeBar({this.occupiedSize, this.maxSize});
  @override
  State<MySizeBar> createState() {
    return _MySizeBarState();
  }
}

class _MySizeBarState extends State<MySizeBar> {
  @override
  Widget build(BuildContext context) {
    final Color background = Colors.white;
    final Color fill = Colors.green;
    final List<Color> gradient = [
      fill,
      fill,
      background,
      background,
    ];
    final List<double> stops = [
      0.0,
      this.widget.occupiedSize / this.widget.maxSize,
      this.widget.occupiedSize / this.widget.maxSize,
      1.0
    ];

    return Container(
      width: 290,
      height: 15,
      margin: EdgeInsets.only(top: 5),
      child: Center(
          child: Text(
        "${this.widget.occupiedSize.toString()} GB | ${this.widget.maxSize.toString()} GB",
        style: TextStyle(fontSize: 10),
      )),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            stops: stops,
            end: Alignment.centerRight,
            begin: Alignment.centerLeft,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black)),
    );
  }
}
