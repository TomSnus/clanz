import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:clanz/models/clanz_game.dart';
import 'package:clanz/ui/CustomIconFactory.dart';

class GamesTile extends StatelessWidget {
  final ClanzGame game;
  final String userId;
  const GamesTile({this.game, this.userId});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: Icon(CustomIconFactory().getIcon(game.icon)),
            title: Text(game.name),
            trailing: new CupertinoSwitch(
              trackColor: Colors.grey[300],
              onChanged: (bool value) {
                //_toggle(game.icon, value);
                game.subscriber[userId] = value;
              },
              value: game.subscriber[userId] ?? false,
            ),
          ),
        ));
  }
}
