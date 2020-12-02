import 'package:custo_usb/models/configuration.dart';
import 'package:custo_usb/widgets/binary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../constants.dart';

class SelectedBinaries extends StatefulWidget {
  Stream<List<BinaryWidget>> binariesStream;

  SelectedBinaries() {
    var config = Configuration();

    binariesStream = config.binariesController.stream;
  }
  @override
  _SelectedBinariesState createState() => _SelectedBinariesState();
}

class _SelectedBinariesState extends State<SelectedBinaries> {
  var config = Configuration();

  @override
  void initState() {
    super.initState();
    widget.binariesStream.listen((event) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (config.selectedBinaries != null)
      config.selectedBinaries.sort((a, b) {
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
              children: config.selectedBinaries
                  .map((e) => Center(
                          child: Stack(
                        children: [
                          Center(
                              child: Text(
                            e.name.length > 7
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
                                          parameter: "binaries", binary: e);
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
