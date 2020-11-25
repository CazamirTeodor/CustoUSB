import 'package:custo_usb/constants.dart';
import 'package:custo_usb/widgets/gui_slider.dart';
import 'package:flutter/material.dart';
import '../widgets/binaries_list.dart';
import '../widgets/selected_binaries.dart';
import '../widgets/size_bar.dart';

class ToolsSection extends StatefulWidget {
  @override
  _ToolsSectionState createState() => _ToolsSectionState();
}

class _ToolsSectionState extends State<ToolsSection> {
  TextEditingController _controller = TextEditingController();

  List<String> allBinaries = ["bash", "zsh", "xterm", "curl"];
  List<String> selectedBinaries = ["ssh"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SelectedBinaries(list: selectedBinaries),
            BinariesList(list: allBinaries)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Graphical mode:",
              style: kTextStyle(kColor: Colors.black),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20)),
            GuiSlider(),
          ],
        ),
        MySizeBar(
          occupiedSize: 3.23,
          maxSize: 8.00,
        )
      ],
    );
  }

  void updateBinary({String mode, String name}) {
    switch (mode) {
      case "add":
        setState(() {
          selectedBinaries.add(name);
        });
        break;

      case "remove":
        setState(() {
          selectedBinaries.remove(name);
        });
        break;
    }
  }
}
