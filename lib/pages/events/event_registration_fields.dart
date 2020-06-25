import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:clanz/database/database_service.dart';
import 'package:clanz/models/clanz_game.dart';
import 'package:clanz/pages/games/games_tile.dart';

class EventRegistrationFields extends StatefulWidget {
  @override
  _EventRegistrationFieldsState createState() =>
      _EventRegistrationFieldsState();
}

class _EventRegistrationFieldsState extends State<EventRegistrationFields> {
  DatabaseService dbService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<ClanzGame>(
        builder: (context, game, child) {
          return FutureBuilder<String>(
              future: dbService.getUserId(),
              builder: (context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return new Card(
                    child: Text('game.name'),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              });
        },
      ),
    ); //return Scaffold();
  }
}
