import 'package:custo_usb/constants.dart';
import 'package:custo_usb/widgets/gui_slider.dart';
import 'package:flutter/material.dart';
import '../widgets/binaries_list.dart';
import '../widgets/selected_binaries.dart';
import '../widgets/size_bar.dart';
import '../models/configuration.dart';
import '../widgets/binary.dart';

class ToolsSection extends StatefulWidget {
  Stream<List<BinaryWidget>> binariesStream;
  Stream<String> driveStream;

  Widget allBinaries = BinariesList();

  ToolsSection() {
    var config = Configuration();
    binariesStream = config.binariesController.stream;
    driveStream = config.driveController.stream;
  }
  @override
  _ToolsSectionState createState() => _ToolsSectionState();
}

class _ToolsSectionState extends State<ToolsSection> {
  @override
  void initState() {
    super.initState();
    widget.driveStream.listen((drive) {
      setState(() {});
    });

    widget.binariesStream.listen((event) {
      setState(() {});
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
            widget.allBinaries,
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
        MySizeBar()
      ],
    );
  }
}
