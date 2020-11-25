import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import '../constants.dart';
import '../models/distro.dart';
import '../widgets/dropdown_button.dart';

class SpecsSection extends StatelessWidget {
  List<Distro> distros = List<Distro>();
  Distro currentDistro;
  StreamController<String> currentDistroController = StreamController<String>();

  @override
  Widget build(BuildContext context) {
    distros = [];
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString("assets/distros.json"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> json = jsonDecode(snapshot.data);

          var distros_from_json = json['distributions'];

          distros_from_json.forEach((element) {
            distros.add(Distro.fromJson(element));
          });

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "Distro:",
                    style: kTextStyle(kColor: Colors.black),
                  ),
                  MyDropdownButton(
                    options: distros.map((e) => e.name).toList(),
                    updateParameter: "distro",
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    "Version:",
                    style: kTextStyle(kColor: Colors.black),
                  ),
                  MyDropdownButton(
                    options:
                        currentDistro != null ? currentDistro.versions : [],
                    updateParameter: "version",
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    "Architecture:",
                    style: kTextStyle(kColor: Colors.black),
                  ),
                  MyDropdownButton(
                    options: currentDistro != null ? currentDistro.archs : [],
                    updateParameter: "architecture",
                  )
                ],
              )
            ],
          );
        } else
          return Center(
            child: Text(
              "Reconfigure \"distros.json\" file.",
              style: kTextStyle(kColor: Colors.black),
            ),
          );
      },
    );
  }

  void controllerFunction(String currentDistro) {
    this.currentDistro =
        distros.firstWhere((element) => element.name != currentDistro);
  }
}
