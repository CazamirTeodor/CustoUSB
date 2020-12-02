import 'package:custo_usb/models/configuration.dart';
import 'package:flutter/material.dart';
import '../widgets/binary.dart';
import 'dart:io';

class MySizeBar extends StatefulWidget {
  int binariesSize = 0;
  int maxDriveSize;

  Stream<List<BinaryWidget>> binariesStream;

  MySizeBar() {
    updateBinariesSize();

    var config = Configuration();
    binariesStream = config.binariesController.stream;
  }

  @override
  _MySizeBarState createState() => _MySizeBarState();

  int getDriveSize() {
    int to_return = 0;
    var drive = Configuration().drive;

    var drives =
        Process.runSync("df", ["-m", "-P"]).stdout.toString().split("\n");
    drives.removeWhere((element) => !element.contains(new RegExp(r'/dev')));

    drives.forEach((element) {
      element.trim();
      var list = element.split(" ");
      list.removeWhere((element) => element == "");
      if (list[0] == drive) {
        to_return = int.parse(list[1]);
        return;
      }
    });

    return to_return;
  }

  void updateBinariesSize() {
    var config = Configuration();
    config.binaries.forEach((element) {
      binariesSize += element.dimension;
    });
    maxDriveSize = getDriveSize();
  }
}

class _MySizeBarState extends State<MySizeBar> {
  int driveSize = 0;

  @override
  void initState() {
    super.initState();
    widget.binariesStream.listen((event) {
      widget.updateBinariesSize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color background = Colors.white;
    final Color fill = (driveSize + widget.binariesSize) > widget.maxDriveSize
        ? Colors.red
        : Colors.green;
    final List<Color> gradient = [
      fill,
      fill,
      background,
      background,
    ];
    final List<double> stops = [
      0.0,
      (driveSize + widget.binariesSize) / widget.maxDriveSize,
      (driveSize + widget.binariesSize) / widget.maxDriveSize,
      1.0
    ];

    return Container(
      width: 290,
      height: 20,
      margin: EdgeInsets.only(top: 5),
      child: Center(
          child: Text(
        "${(driveSize + widget.binariesSize)} MB | ${widget.maxDriveSize} MB",
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
