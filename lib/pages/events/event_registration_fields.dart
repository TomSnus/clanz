import 'dart:js';

import 'package:clanz/presentaion/clanz_colors.dart';
import 'package:clanz/shared/constants.dart';
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
  List<DropdownMenuItem<String>> itemList;
  DatabaseService dbService = DatabaseService();
  String _selectedValue;

  String _currentName;
  @override
  Widget build(BuildContext context) {
    List<ClanzGame> games;
    return FutureBuilder<String>(
        future: dbService.getUserId(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          games = Provider.of<List<ClanzGame>>(context, listen: false);
          if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    Text('Erstelle ein Event',
                        style: TextStyle(
                          fontSize: 18.0,
                        )),
                    SizedBox(height: 20.0),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[Text('Event Name:'),
                        TextFormField(
                          decoration: textInputDecoration,
                          validator: (val) =>
                              val.isEmpty ? 'Name des Events' : null,
                          onChanged: (val) => setState(() => _currentName = val),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    DropdownButton(
                        items: getListItems(games),
                        value: _selectedValue,
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value;
                          });
                        })
                  ],
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });

    //return Scaffold();
  }

  getListItems(List<ClanzGame> games) {
    if (itemList == null) {
      itemList = [];
      for (ClanzGame game in games) {
        itemList.add(
            DropdownMenuItem<String>(child: Text(game.name), value: game.name));
      }
    }
    return itemList;
  }
}

/*
DropdownButton(
                          items: getListItems(games),
                          value: _selectedValue,
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          })
                          */
