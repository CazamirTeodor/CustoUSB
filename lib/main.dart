import 'dart:async';
import 'package:flutter/material.dart';

import './sections/drive_section.dart';
import './sections/specs_section.dart';
import './sections/ldap_section.dart';
import './models/configuration.dart';
import './widgets/progress_bar.dart';
import './widgets/burn_button.dart';

void main() {
  runApp(CustoUSB());
}

class CustoUSB extends StatefulWidget {
  @override
  _CustoUSBState createState() => _CustoUSBState();
}

class _CustoUSBState extends State<CustoUSB> {
  var config = Configuration();

  bool burning = false;
  Stream<bool> burningStream;

  @override
  void initState()
  {
    burningStream = config.burningController.stream;
    super.initState();
    burningStream.listen((event) {
      setState((){
        burning = true;
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "CustoUSB",
        home: Scaffold(
          body: !burning
              ? ConfigPage()
              : BurningPage()
        ));
  }
}

class ConfigPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DriveSection(),
        Divider(thickness: 0.5, color: Colors.black),
        SpecsSection(),
        Divider(thickness: 0.5, color: Colors.black),
        // ToolsSection(toolsFunction: config.inputBinaries),
        Divider(thickness: 0.5, color: Colors.black),
        LDAPSection(),
        Divider(thickness: 1, color: Colors.black, height: 0,),
        BurnButton()
      ],
    );
  }
}

class BurningPage extends StatelessWidget {
  //String script;

  //BurningPage({this.script});

  @override
  Widget build(BuildContext context) {
    return MyProgressBar();
  }
}
