import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clanz/services/authentication.dart';
import 'package:clanz/pages/root_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Clanz',
        debugShowCheckedModeBanner: false,
        //theme: ThemeData.dark(),

        theme: new ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.red[900],
          accentColor: Colors.cyan[600],
        ),
        home: new RootPage(auth: new Auth()));
  }
}
