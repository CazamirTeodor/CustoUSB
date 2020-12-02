import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../constants.dart';
import '../models/configuration.dart';

class BinaryWidget extends StatefulWidget {
  String name;
  int dimension;

  BinaryWidget({this.name});

  @override
  _BinaryWidgetState createState() => _BinaryWidgetState();
}

class _BinaryWidgetState extends State<BinaryWidget> {
  bool status = false;
  var config = Configuration();

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.name,
      waitDuration: Duration(milliseconds: 500),
      child: FlatButton(
        color: status ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.white, width: 0.7)),
        child: Text(widget.name,
            style: kTextStyle(kColor: status ? Colors.black : Colors.white)),
        visualDensity: VisualDensity(vertical: 1.5, horizontal: -3),
        mouseCursor: MouseCursor.defer,
        onPressed: () {
          setState(() {
            status = !status;
            config.updateParameter(
                parameter: "binaries", binaryName: widget.name);
          });
        },
      ),
    );
  }
}
