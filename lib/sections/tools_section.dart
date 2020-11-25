import 'package:flutter/material.dart';
import '../widgets/binaries_list.dart';
import '../widgets/selected_binaries.dart';
import '../widgets/size_bar.dart';

class ToolsSection extends StatelessWidget {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          SelectedBinaries(),
          BinariesList()
        ],),
      MySizeBar(occupiedSize: 3.23 , maxSize: 8.00,)
      ],
    );
  }
}
