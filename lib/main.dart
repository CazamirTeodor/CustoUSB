import 'package:flutter/material.dart';

import './sections/drive_section.dart';
import './sections/specs_section.dart';

void main() {
  runApp(CustoUSB());
}

class CustoUSB extends StatelessWidget {
  bool configured = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
        debugShowCheckedModeBanner: false,
        title: "CustoUSB",
        home: Scaffold(
          body: !configured?ConfigPage():BurningPage(),
        ));
  }
}

class ConfigPage extends StatelessWidget {
  String drive, distro, version, architecture;
  List<String> binaries;
  String ip, domain;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DriveSection(),
        Divider(thickness: 0.5, color: Colors.black),
        SpecsSection(),
        // Divider(),
        // ToolsSection(),
        // Divider(),
        // LDAPSection(),
        // BurnButton()
      ],
    );
  }
}

class BurningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("To do");
  }
}
