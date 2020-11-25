import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import '../constants.dart';

class Binary extends StatefulWidget {
  String name;
  Function updateFunction;

  Binary({this.name});

  @override
  BinaryState createState() => BinaryState();
}

class BinaryState extends State<Binary> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: !_checked ? Colors.black : Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.white, width: 0.7)),
      child: Text(
        this.widget.name,
        style: kTextStyle(kColor: _checked?Colors.black:Colors.white)
      ),
      visualDensity: VisualDensity(vertical: 1.5, horizontal: -3),
      mouseCursor: MouseCursor.defer,
      onPressed: () {
        setState(() {
          _checked = !_checked;
          if(_checked)
            //widget.updateFunction(mode: "add",value: )
          print("Am apasat butonul!");
        });
      },
    );
  }
}
