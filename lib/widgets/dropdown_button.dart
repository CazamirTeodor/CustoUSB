import 'dart:async';

import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/configuration.dart';

class MyDropdownButton extends StatefulWidget {
  List<String> options = [];
  String updateParameter;
  var configuration = Configuration();

  Function updateFunction;

  MyDropdownButton(
      {@required this.options,
      @required this.updateParameter,
      this.updateFunction});

  @override
  State<MyDropdownButton> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String selectedOption;

  @override
  Widget build(BuildContext context) {
    widget.options.singleWhere((element) {
          return element == selectedOption;
        },orElse: () {
          selectedOption = null;
          widget.configuration.updateParameter(parameter: widget.updateParameter, value: "");
        });

    return Container(
      width: 100,
      height: 20,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          value: selectedOption,
          items: this.widget.options.map<DropdownMenuItem<String>>((e) {
            return DropdownMenuItem<String>(
              value: e,
              child: Center(
                  child: Text(
                e,
                style: kTextStyle(kColor: Colors.black),
              )),
            );
          }).toList(),
          iconSize: 0,
          hint: Center(
              child: Text(
            "Choose",
            style: kTextStyle(kColor: Colors.grey),
          )),
          onChanged: (e) {
            setState(() {
              widget.configuration
                  .updateParameter(parameter: widget.updateParameter, value: e);
              selectedOption = e;
              if (widget.updateFunction != null) widget.updateFunction(e);
            });
          },
        ),
      ),
    );
  }
}
