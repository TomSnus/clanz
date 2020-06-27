import 'package:clanz/presentaion/clanz_colors.dart';
import 'package:flutter/material.dart';
import 'package:clanz/presentaion/clanz_colors.dart';

InputDecoration textInputDecoration = InputDecoration(
  fillColor:  ClanzColors.getSecColor(),
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);

ShapeDecoration dropDownDecoration = ShapeDecoration(
  color: ClanzColors.getSecColor(),
  shape: RoundedRectangleBorder(
    side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.white),
    borderRadius: BorderRadius.circular(18.0),
  ),
);
