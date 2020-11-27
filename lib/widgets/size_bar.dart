import 'package:custo_usb/models/configuration.dart';
import 'package:flutter/material.dart';
import '../models/binary.dart';

class MySizeBar extends StatelessWidget {
  int binariesSize = 0;
  int driveSize = 0;
  int maxDriveSize = 4000;

  MySizeBar() {
    var config = Configuration();
    config.binaries.forEach((element) {
      binariesSize += element.getDimension();
    });
    driveSize = getDriveSize(config.drive);
  }

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
        "${(driveSize + binariesSize).toString()} MB | ${maxDriveSize.toString()} MB",
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

  int getDriveSize(String driveName) {
    return 2000;
  }
}
