import 'package:custo_usb/models/configuration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import '../constants.dart';
import 'binary.dart';

class BinariesList extends StatefulWidget {
  List<BinaryWidget> list = [];

  var config = Configuration();

  BinariesList() {
    String result =
        Process.runSync("apt-cache", ["search", "."]).stdout.toString();
    List<String> rows = result.split("\n");
    rows.forEach((element) {
      List<String> row = element.split(" ");
      list.add(BinaryWidget(name: row[0]));
    });
    getDimensions();
  }

  @override
  _BinariesListState createState() => _BinariesListState();

  void getDimensions() {
    List<int> to_return = List<int>();

    list.forEach((element) {
      var result = Process.runSync(
              "apt-cache", ["--no-all-versions", "show", element.name])
          .stdout
          .toString();
      List<String> rows = result.split("\n");
      rows.removeWhere((element) => !element.startsWith("Installed-Size:"));
      if (rows.length == 0) {
        rows = result.split("\n");
        rows.removeWhere((element) => !element.startsWith("Size:"));
      }

      List<String> row = rows[0].split(" ");
      element.dimension = int.parse(row[1]);
      print(element.name + " " + element.dimension.toString());
    });
  }
}

class _BinariesListState extends State<BinariesList> {
  String searchItem = "";

  @override
  Widget build(BuildContext context) {
    widget.list = [];
    widget.list.sort((a, b) {
      return a.name.compareTo(b.name);
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: 120,
            height: 20,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search...",
              ),
              textAlign: TextAlign.center,
              cursorHeight: 11,
              style: kTextStyle(kColor: Colors.black),
              onChanged: (val) {
                setState(() {
                  searchItem = val;
                });
              },
            )),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          margin: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.black),
          width: 200,
          height: 170,
          child: GridView.count(
            childAspectRatio: 2,
            crossAxisCount: 3,
            mainAxisSpacing: 3,
            crossAxisSpacing: 7,
            padding: EdgeInsets.all(5),
            children: searchItem.length > 0
                ? widget.list
                    .where((element) => element.name.startsWith(searchItem))
                    .toList()
                : widget.list,
          ),
        ),
      ],
    );
  }
}
