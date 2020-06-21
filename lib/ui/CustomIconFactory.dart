import 'package:clanz/presentaion/custom_icon_icons.dart';
import 'package:flutter/material.dart';

class CustomIconFactory {
  IconData getIcon(String iconId) {
    switch (iconId) {
      case 'lol':
        return CustomIcon.icons8_league_of_legends;
      case 'dnd':
        return CustomIcon.dnd;
      case 'buchklub':
        return CustomIcon.counter_strike;
      case 'buchklub':
        return Icons.book;
      default:
        return Icons.hourglass_empty;
    }
  }
}
