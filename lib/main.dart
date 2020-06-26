import 'package:clanz/database/database_service.dart';
import 'package:clanz/locator.dart';
import 'package:clanz/models/clanz_game.dart';
import 'package:clanz/presentaion/clanz_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clanz/services/authentication.dart';
import 'package:clanz/pages/root_page.dart';
import 'package:provider/provider.dart';
import 'package:clanz/models/clanz_game.dart';
import 'managers/dialog_manager.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setupLocator();
    return StreamProvider<List<ClanzGame>>.value(
      value: DatabaseService().games,
      child: MaterialApp(
        theme: new ThemeData(
          brightness: Brightness.dark,
          primaryColor: ClanzColors.getPrimaryColor(),
          accentColor: ClanzColors.getSecColor(),
        ),
        builder: (context, widget) => Navigator(
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(
              child: widget,
            ),
          ),
        ),
        title: 'Clanz',
        home: new RootPage(auth: new Auth()),
      ),
    );
  }
}
