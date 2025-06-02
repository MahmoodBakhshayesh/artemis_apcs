import 'package:flutter/material.dart';

class GeneralButtonStyle {
  final BorderRadius borderRadius;
  final Color foregroundColor;
  final Color backgroundColor;
  final IconData? icon;
  final double fontSize;
  final FontWeight fontWeight;
  final double? width;
  final double? height;

  GeneralButtonStyle({this.borderRadius = const BorderRadius.all(Radius.circular(30)),this.height,this.width, this.foregroundColor = Colors.white,this.fontWeight = FontWeight.normal, this.backgroundColor = Colors.blueAccent, this.icon, this.fontSize =13});
}
