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

  @override
  _BinariesListState createState() => _BinariesListState();
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
        FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString("assets/binaries.json"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> json = jsonDecode(snapshot.data);

                var binaries_from_json = json['binaries'];

                binaries_from_json.forEach((element) {
                  widget.list.add(BinaryWidget(name: element));
                });
              }
              List<int> dimensions = getDimensions(widget.list);
              for (int i = 0; i < dimensions.length; i++) {
                widget.list[i].dimension = dimensions[i];
              }

              return Container(
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
                          .where(
                              (element) => element.name.startsWith(searchItem))
                          .toList()
                      : widget.list,
                ),
              );
            }),
      ],
    );
  }

  List<int> getDimensions(List<BinaryWidget> list) {
    List<int> to_return = List<int>();
    StringBuffer packages_names = StringBuffer();

    list.forEach((element) {
      packages_names.write(element.name + " ");
    });

    var result = Process.runSync("apt-cache", [
      "--no-all-versions",
      "show",
      packages_names.toString()
    ]).stdout.toString();
    List<String> rows = result.split("\n");
    rows.removeWhere((element) => !element.startsWith("Installed-Size:"));
    rows.forEach((element) {
      List<String> row = element.split(" ");
      to_return.add(int.parse(row[1]));
    });

    return to_return;
  }
}
