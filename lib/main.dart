import 'package:clanz/models/clanz_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:clanz/database/database_service.dart';
import 'package:clanz/locator.dart';
import 'package:clanz/models/clanz_game.dart';
import 'package:clanz/models/clanz_game.dart';
import 'package:clanz/pages/root_page.dart';
import 'package:clanz/presentaion/clanz_colors.dart';
import 'package:clanz/services/authentication.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
    return MultiProvider(
      providers: [
        StreamProvider<List<ClanzGame>>.value(value: DatabaseService().games),
        StreamProvider<ClanzUser>.value(value: DatabaseService().user)
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('de', ''),
        ],
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
