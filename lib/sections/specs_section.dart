import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/dropdown_button.dart';

class SpecsSection extends StatelessWidget
{
  @override 
  Widget build(BuildContext context)
  {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        children: [
          Text("Distro:", style: kTextStyle(kColor: Colors.black),),
          MyDropdownButton(options: ["op1", "op2"])
        ],
      ),
      Column(
        children: [
          Text("Version:", style: kTextStyle(kColor: Colors.black),),
          MyDropdownButton(options: ["op1", "op2"])
        ],
      ),
      Column(
        children: [
          Text("Architecture:", style: kTextStyle(kColor: Colors.black),),
          MyDropdownButton(options: ["op1", "op2"])
        ],
      )
    ],);
  }
}