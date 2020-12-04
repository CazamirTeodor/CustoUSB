import 'package:custo_usb/models/configuration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class BinariesList extends StatefulWidget {

  @override
  _BinariesListState createState() => _BinariesListState();
}

class _BinariesListState extends State<BinariesList> {
  String searchItem = "";
  var config = Configuration();

  @override
  Widget build(BuildContext context) {
    

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
                ? config.allBinaries
                    .where((element) => element.name.startsWith(searchItem))
                    .toList()
                : config.allBinaries,
          ),
        ),
      ],
    );
  }
}

