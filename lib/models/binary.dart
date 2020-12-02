import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/configuration.dart';
import 'dart:io';

class Binary {
  String name;
  int dimension;

  Binary({this.name}) {}

  int getDimension() {
    if (dimension != null)
      return dimension;
    else {
      if (this.name != null) {
        var output = Process.runSync(
            "apt-cache", ["--no-all-versions", "show", "${this.name}"]);
        if (output.exitCode == 0) {
          List<String> rows = output.stdout.toString().split("\n");
          rows.removeWhere((element) => !element.startsWith("Installed-Size:"));
          List<String> cols = rows[0].split(" ");

          dimension = int.parse(cols[1]);
          return dimension;
        }
      } else {
        return 0;
      }
    }
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
