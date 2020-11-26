import 'package:custo_usb/models/configuration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class SelectedBinaries extends StatelessWidget {
  var config = Configuration();
  @override
  Widget build(BuildContext context) {
    if (config.binaries != null)
      config.binaries.sort((a, b) {
        return a.name.compareTo(b.name);
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
              children: config.binaries
                  .map((e) => Center(
                          child: Stack(
                        children: [
                          Center(
                              child: Text(
                            e.name.length > 8
                                ? e.name.substring(0, 5) + "..."
                                : e.name,
                            style: kTextStyle(kColor: Colors.black),
                          )),
                          Positioned(
                            right: 0,
                            top: -1,
                            child: SizedBox(
                                height: 18.0,
                                width: 18.0,
                                child: IconButton(
                                    padding: EdgeInsets.all(1.0),
                                    color: Colors.redAccent,
                                    splashRadius: 1,
                                    icon: new Icon(Icons.close, size: 12.0),
                                    onPressed: () {
                                      print("Trying to delete ${e.name}.");
                                      config.updateParameter(
                                          parameter: "binaries",
                                          binaryName: e.name);
                                    })),
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
