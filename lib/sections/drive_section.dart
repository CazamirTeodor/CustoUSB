import 'package:custo_usb/widgets/dropdown_button.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../constants.dart';
import '../widgets/dropdown_button.dart';

class DriveSection extends StatelessWidget {
  String selectedDrive;
  List<String> drives = List<String>();

  @override
  Widget build(BuildContext context) {
    drives = [];
    getDrives();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Drive: ", style: kTextStyle(kColor: Colors.black)),
          Padding(padding: EdgeInsets.only(right: 10)),
          MyDropdownButton(options: drives),
        ],
      ),
    );
  }

  void getDrives() {
    var temp = Process.runSync('df', []).stdout.toString().split(" ");
    temp.removeWhere((element) => !element.contains(new RegExp(r'/dev')));
    print(temp);
    temp.forEach((element) {
      drives.add(element.split("\n")[1].substring(5));
    });
  }
}
