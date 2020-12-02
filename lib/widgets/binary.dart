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

  int getDimension() {
    if (dimension == null) {
      var output = Process.runSync(
          "apt-cache", ["--no-all-versions", "show", "${name}"]);
      if (output.exitCode == 0) {
        List<String> rows = output.stdout.toString().split("\n");
        rows.removeWhere((element) => !element.startsWith("Installed-Size:"));
        List<String> cols = rows[0].split(" ");

        dimension = int.parse(cols[1]);
        return dimension;
      }
    }
    return dimension;
  }
}

class _BinaryWidgetState extends State<BinaryWidget> {
  bool status = false;
  var config = Configuration();

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
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
    );
  }
}
