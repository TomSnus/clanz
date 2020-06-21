import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:clanz/database/database_service.dart';
import 'package:clanz/models/clanz_game.dart';
import 'package:clanz/pages/games/games_tile.dart';

class SubscribePage2 extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => SubscribePage2(),
      );
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ClanzGame>>.value(
      value: DatabaseService().games,
      child: Scaffold(
        body: GamesList(),
      ),
    );
  }
}

class GamesList extends StatefulWidget {
  @override
  _GamesListState createState() => _GamesListState();
}

class _GamesListState extends State<GamesList> {
  DatabaseService dbService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    final games = Provider.of<List<ClanzGame>>(context);

    if (games == null) {
      return CircularProgressIndicator(
        backgroundColor: Colors.red,
      );
    }
    return FutureBuilder<String>(
        future: dbService.getUserId(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: games.length,
              itemBuilder: (context, index) {
                return GamesTile(game: games[index]);
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        });

    //return Scaffold();
  }
}
