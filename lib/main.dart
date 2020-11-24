import 'package:flutter/material.dart';

import './sections/drive_section.dart';
import './sections/specs_section.dart';
import './sections/ldap_section.dart';
import './models/configuration.dart';
import './widgets/progress_bar.dart';

void main() {
  runApp(CustoUSB());
}

class CustoUSB extends StatefulWidget {
  @override
  _CustoUSBState createState() => _CustoUSBState();
}

class _CustoUSBState extends State<CustoUSB> {
  Configuration config = new Configuration();

  bool configured = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "CustoUSB",
        home: Scaffold(
          body: !configured
              ? ConfigPage(configFunction: inputConfiguration)
              : BurningPage()//script: config.generateScript()),
        ));
  }

  void inputConfiguration(Configuration config) {
    setState(() {
      this.config = config;
      this.configured = true;
    });
  }
}

class ConfigPage extends StatelessWidget {
  Function configFunction;
  Configuration config = new Configuration();

  ConfigPage({@required this.configFunction});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DriveSection(driveFunction: config.inputDrive),
        Divider(thickness: 0.5, color: Colors.black),
        SpecsSection(),
        Divider(thickness: 0.5, color: Colors.black),
        // ToolsSection(toolsFunction: config.inputBinaries),
        Divider(thickness: 0.5, color: Colors.black),
        LDAPSection(ldapFunction: config.inputLDAP),
        Divider(thickness: 0.5, color: Colors.black),
        // BurnButton(burnFunction: configFunction) -- calls configFunction on success
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
