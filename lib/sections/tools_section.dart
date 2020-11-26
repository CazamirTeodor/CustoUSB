import 'package:custo_usb/constants.dart';
import 'package:custo_usb/widgets/gui_slider.dart';
import 'package:flutter/material.dart';
import '../widgets/binaries_list.dart';
import '../widgets/selected_binaries.dart';
import '../widgets/size_bar.dart';
import '../models/configuration.dart';
import '../models/binary.dart';

class ToolsSection extends StatefulWidget {
  Stream<List<Binary>> binariesStream;
  ToolsSection() {
    var config = Configuration();
    binariesStream = config.binariesController.stream;
  }
  @override
  _ToolsSectionState createState() => _ToolsSectionState();
}

class _ToolsSectionState extends State<ToolsSection> {
  List<Binary> selectedBinaries = [];

  @override
  void initState() {
    super.initState();
    widget.binariesStream.listen((event) {
      setState(() {
        selectedBinaries = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SelectedBinaries(),
            BinariesList(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Graphical mode:", style: kTextStyle(kColor: Colors.black)),
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
}
