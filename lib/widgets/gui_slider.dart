import 'dart:async';

import 'package:custo_usb/models/configuration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GuiSlider extends StatefulWidget {
  List<String> list = ["CLI", "GUI"];

  @override
  _GuiSliderState createState() => _GuiSliderState();
}

class _GuiSliderState extends State<GuiSlider> {
  int index = 0, oldIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoSlidingSegmentedControl(
        groupValue: index,
        backgroundColor: Colors.grey[300],
        thumbColor: Colors.black,
        children: this.widget.list.asMap().map((index, e) {
          return MapEntry(
            index,
            Text(
              e,
              style: TextStyle(
                  color: index == oldIndex ? Colors.white : Colors.black,
                  fontFamily: 'Avenir'),
            ),
          );
        }),
        onValueChanged: (val) {
          var config = Configuration();
          config.updateParameter(parameter: "binaries", binaryName: "gui1");
          config.updateParameter(parameter: "binaries", binaryName: "gui2");
          config.updateParameter(parameter: "binaries", binaryName: "gui3");

          setState(() {
            oldIndex = val;
            index = val;
          });
        },
      ),
    );
  }
}
