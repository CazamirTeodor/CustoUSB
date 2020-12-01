import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../constants.dart';
import '../models/configuration.dart';

class RootSubsection extends StatefulWidget {
  @override
  State<RootSubsection> createState() => _RootSubsectionState();
}

class _RootSubsectionState extends State<RootSubsection> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        padding: EdgeInsets.only( left: 10, right: 4),
        child: Text("Root password :",
            style: kTextStyle(kColor: Colors.yellowAccent)),
      ),
      Container(
          width: 120,
          height: 20,
          decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: TextField(
            obscureText: !visible,
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
            ),
            textAlign: TextAlign.center,
            cursorHeight: 11,
            style: kTextStyle(kColor: Colors.white),
            onChanged: (val) {
              var configuration = Configuration();
              configuration.updateParameter(
                  parameter: "rootPassword", value: val); // change to root pass
            },
          )),
      Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 5, left: 17),
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: visible
                  ? AssetImage("assets/checked.png")
                  : AssetImage("assets/unchecked.png"),
            )),
            child: FlatButton(
              mouseCursor: MouseCursor.defer,
              child: null,
              onPressed: () {
                setState(() {
                  visible = !visible;
                });
              },
            ),
          ),
          Text("Show", style: kTextStyle(kColor: Colors.white)),
        ],
      ),
    ]);
  }
}
