import 'dart:async';

import 'package:flutter/material.dart';
import '../models/configuration.dart';

class BurnButton extends StatefulWidget {
  var configuration = Configuration();

  bool burning = false;
  Stream<bool> configuredStream;

  BurnButton() {
    configuredStream = configuration.configuredController.stream;
  }

  @override
  _BurnButtonState createState() => _BurnButtonState();
}

class _BurnButtonState extends State<BurnButton> {
  @override
  void initState() {
    super.initState();
    this.widget.configuredStream.listen((event) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 70,
      decoration: BoxDecoration(
          color: widget.configuration.configured
              ? Colors.green
              : Colors.redAccent),
      child: FlatButton(
        child: Text(
          "BURN",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Avenir',
              fontWeight: FontWeight.w800,
              letterSpacing: 9,
              fontSize: 30),
        ),
        onPressed: () {
          widget.configuration.printStats();
          if (widget.configuration.configured)
            widget.configuration.burningController.add(true);
        },
        splashColor: Colors.transparent,
      ),
    );
  }
}
