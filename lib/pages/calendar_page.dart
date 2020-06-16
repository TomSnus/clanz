import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CalendarPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => CalendarPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Yo"),
      ),
    );
  }
}