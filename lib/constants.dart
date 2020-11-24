import 'package:flutter/material.dart';

class kTextStyle extends TextStyle {
  final Color kColor;

  kTextStyle({this.kColor})
      : super(color: kColor, fontSize: 12, fontFamily: 'Avenir');
}
