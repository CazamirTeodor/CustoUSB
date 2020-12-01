import 'package:custo_usb/models/configuration.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class MySizeBar extends StatelessWidget {
  int binariesSize = 0;
  int driveSize = 0;
  int maxDriveSize;

  MySizeBar() {
    var config = Configuration();
    config.binaries.forEach((element) {
      binariesSize += element.getDimension();
    });
    maxDriveSize = getDriveSize();
  }

  @override
  Widget build(BuildContext context) {
    final Color background = Colors.white;
    final Color fill =
        (driveSize + binariesSize) > maxDriveSize ? Colors.red : Colors.green;
    final List<Color> gradient = [
      fill,
      fill,
      background,
      background,
    ];
    final List<double> stops = [
      0.0,
      (driveSize + binariesSize) / maxDriveSize,
      (driveSize + binariesSize) / maxDriveSize,
      1.0
    ];

    return Container(
      width: 290,
      height: 20,
      margin: EdgeInsets.only(top: 5),
      child: Center(
          child: Text(
        "${(driveSize + binariesSize)} MB | ${maxDriveSize} MB",
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

  int getDriveSize() {
    int to_return = 0;
    var drive = Configuration().drive;

    var drives = Process.runSync("df", ["-m"]).stdout.toString().split("\n");
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
}
