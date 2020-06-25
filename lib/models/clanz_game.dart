import 'package:flutter/cupertino.dart';

class ClanzGame extends ChangeNotifier {
  final String name;
  final String icon;
  final Map<String, dynamic> subscriber;

  ClanzGame({this.name, this.icon, this.subscriber});

}
