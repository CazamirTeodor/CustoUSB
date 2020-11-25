import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GuiSlider extends StatefulWidget {
  List<String> list = ["CLI", "GUI"];

  @override
  _GuiSliderState createState() => _GuiSliderState();
}

class _GuiSliderState extends State<GuiSlider> {
  int index;
  int oldIndex;

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
            if (widget.list[val] == "GUI")
              {
                //add graphical packets in selected binaries
              }
            else
            {
              // remove them
            }
            setState(() {
              oldIndex = val;
              index = val;
            });
          }),
    );
  }
}
