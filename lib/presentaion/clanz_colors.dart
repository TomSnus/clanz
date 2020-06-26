import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class ClanzColors {
  static Color getPrimaryColor() {
    return HexColor('#4ae8db');
  }

  static Color getPrimaryColorLight() {
    return HexColor('#88ffff');
  }

  static Color getPrimaryColorDark() {
    return HexColor('#00b5a9');
  }

  static Color getSecColor() {
    return HexColor('#6587e8');
  }

  static Color getSecColorLight() {
    return HexColor('#9ab6ff');
  }

  static Color getSecColorDark() {
    return HexColor('#295bb5');
  }
}
