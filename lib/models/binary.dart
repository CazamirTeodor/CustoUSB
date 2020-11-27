import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/configuration.dart';

class Binary {
  String name;
  int dimension;

  Binary({this.name});

  int getDimension()
  {
    return 100;
  }

  Widget getWidget({bool enabled}) {
    return BinaryWidget(name: this.name, status: enabled);
  }
}

class BinaryWidget extends StatefulWidget {
  String name;
  bool status;
  var config = Configuration();

  BinaryWidget({this.name, this.status});

  @override
  _BinaryWidgetState createState() => _BinaryWidgetState();
}

class _BinaryWidgetState extends State<BinaryWidget> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: widget.status ? Colors.white : Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.white, width: 0.7)),
      child: Text(this.widget.name,
          style:
              kTextStyle(kColor: widget.status ? Colors.black : Colors.white)),
      visualDensity: VisualDensity(vertical: 1.5, horizontal: -3),
      mouseCursor: MouseCursor.defer,
      onPressed: () {
        setState(() {
          widget.config
              .updateParameter(parameter: "binaries", binaryName: widget.name);
        });
      },
    );
  }
}
