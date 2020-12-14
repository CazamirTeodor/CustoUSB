import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:window_size/window_size.dart';

import './sections/drive_section.dart';
import './sections/specs_section.dart';
import './sections/ldap_section.dart';
import './sections/tools_section.dart';
import './models/configuration.dart';
import './widgets/progress_bar.dart';
import './widgets/burn_button.dart';
import './widgets/warning.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
  //   setWindowMinSize(const Size(350, 613));
  //   setWindowMaxSize(const Size(350, 613));
  // }
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
  void initState() {
    burningStream = config.burningController.stream;
    super.initState();
    burningStream.listen((event) {
      setState(() {
        burning = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "CustoUSB",
        home: Scaffold(body: burning ? ConfigPage() : BurningPage()));
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
        ToolsSection(),
        Divider(thickness: 0.5, color: Colors.black),
        LDAPSection(),
        Warning(),
        Divider(
          thickness: 1,
          color: Colors.black,
          height: 0,
        ),
        BurnButton()
      ],
    );
  }
}

class BurningPage extends StatelessWidget {
  StreamController<double> progressController = StreamController<double>();
  BurningPage() {
    burnFunction();
  }

  @override
  Widget build(BuildContext context) {
    return MyProgressBar(stream: progressController.stream); // StreamController
  }

  Future<void> burnFunction() async {
    List<String> scripts = [
      "aplicatii_1.sh",
      "bootstrap_2.sh",
      "chroot_3.sh",
      "install_4.sh",
      "ldap_setup_5.sh",
      "password_6.sh",
      "finish_7.sh",
      "burn_8.sh"
    ];

    print("Started burning...");
    // clone all scripts
    String link_template =
        "https://raw.githubusercontent.com/CazamirTeodor/custo_usb/Linux/scripts/";

    scripts.forEach((element) async {
      await Process.run("curl", ["$link_template$element", "-O"])
          .then((_) => Process.run("chmod", ["+x", "$element"]));
    });

    print("Scripts fetched");

    await Process.run("./aplicatii_1.sh", [])
        .then((value) {
          print(value.stdout);
          print(value.stderr);
          progressController.add(10);
          });
    
    await Process.run("rm", scripts);
  }
}
