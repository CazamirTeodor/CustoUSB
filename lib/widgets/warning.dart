import 'package:custo_usb/constants.dart';
import 'package:flutter/material.dart';

class Warning extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      width: 320,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.amberAccent, width: 0.5)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 15.0,
            width: 15.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/warning.png"),
              ),
            ),
          ),
          Text(
            "Your drive will be formatted! Please save all your data.",
            style: kTextStyle(
              kColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
