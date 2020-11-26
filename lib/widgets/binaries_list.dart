import 'package:custo_usb/models/configuration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../constants.dart';
import '../models/binary.dart';

class BinariesList extends StatefulWidget {
  List<Binary> list = [];
  BinariesList();

  var config = Configuration();

  @override
  _BinariesListState createState() => _BinariesListState();
}

class _BinariesListState extends State<BinariesList> {
  //TextEditingController _controller = TextEditingController();
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
              //controller: _controller,
              onChanged: (val) {
                print("Termenul scris: ${val}.");
                setState(() {
                  searchItem = val;
                });

                // update binaries list if the name is not empty
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
                  widget.list.add(Binary(name: element));
                });
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
                          .map((e) {
                          if (widget.config.binaries
                              .any((element) => element.name == e.name))
                            return e.getWidget(enabled: true);
                          return e.getWidget(enabled: false);
                        }).toList()
                      : widget.list.map((e) {
                          if (widget.config.binaries
                              .any((element) => element.name == e.name))
                            return e.getWidget(enabled: true);
                          return e.getWidget(enabled: false);
                        }).toList(),
                ),
              );
            }),
      ],
    );
  }
}
