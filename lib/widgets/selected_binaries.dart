import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class SelectedBinaries extends StatefulWidget {
  List<String> wantedBinaries = ["xxh", "xterm"];

  @override
  SelectedBinariesState createState() => SelectedBinariesState();
}

class SelectedBinariesState extends State<SelectedBinaries> {
  @override
  Widget build(BuildContext context) {
    widget.wantedBinaries.sort((a, b) {
      return a.compareTo(b);
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Binaries:",
          style: kTextStyle(kColor: Colors.black),
        ),
        Container(
            width: 80,
            height: 170,
            margin: EdgeInsets.only(top: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black)),
            child: ListView(
              children: this
                  .widget
                  .wantedBinaries
                  .map((e) => Center(
                          child: Stack(
                        children: [
                          Text(e),
                          Positioned(
                            child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {},
                              iconSize: 12,
                              color: Colors.red,
                              splashRadius: 0.1,
                              visualDensity: VisualDensity.compact,
                            ),
                          )
                        ],
                      )))
                  .toList(),
              padding: EdgeInsets.all(5),
            )),
      ],
    );
  }
}
