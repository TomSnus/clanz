import 'dart:js';

import 'package:clanz/models/clanz_event.dart';
import 'package:clanz/presentaion/clanz_colors.dart';
import 'package:clanz/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import 'package:clanz/database/database_service.dart';
import 'package:clanz/models/clanz_game.dart';
import 'package:clanz/pages/games/games_tile.dart';

class EventRegistrationFields extends StatefulWidget {
  static of(BuildContext context, {bool root = false}) => root
      ? context.findRootAncestorStateOfType<_EventRegistrationFieldsState>()
      : context.findAncestorStateOfType<_EventRegistrationFieldsState>();
  @override
  _EventRegistrationFieldsState createState() =>
      _EventRegistrationFieldsState();
}

class _EventRegistrationFieldsState extends State<EventRegistrationFields> {
  List<DropdownMenuItem<String>> itemList;
  Icon _gameIcon = Icon(Entypo.game_controller);
  DatabaseService dbService = DatabaseService();

  //Event fields
  String _selectedValue;
  String _selectedDescription;
  String _selectedName;
  static DateTime _selectedDate = DateTime.now();

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
                    Text('Event Name:'),
                    TextFormField(
                      cursorColor: Colors.white,
                      decoration: textInputDecoration,
                      validator: (val) =>
                          val.isEmpty ? 'Name des Events' : null,
                      onChanged: (val) => setState(() => _selectedName = val),
                    ),
                    SizedBox(height: 20.0),
                    Text('Game:'),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 60.0),
                      decoration: dropDownDecoration,
                      child: DropdownButton(
                          items: getListItems(games),
                          value: _selectedValue,
                          icon: _gameIcon,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          onChanged: (value) {
                            setState(() {
                              _gameIcon = null;
                              _selectedValue = value;
                            });
                          }),
                    ),
                    SizedBox(height: 20.0),
                    getDateControl(context),
                    SizedBox(height: 20.0),
                    getDescriptionControl(),
                    SizedBox(height: 20.0),
                    getAcceptButtonControl(context),
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

  Center getDescriptionControl() {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Beschreibung:'),
        TextFormField(
          maxLines: null,
          keyboardType: TextInputType.multiline,
          cursorColor: Colors.white,
          decoration: textInputDecoration,
          validator: (val) => val.isEmpty ? 'Name des Events' : null,
          onChanged: (val) => setState(() => _selectedDescription = val),
        ),
      ],
    ));
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Center getDateControl(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Datum: " + "${_selectedDate.toLocal()}".split(' ')[0]),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            color: ClanzColors.getSecColor(),
            elevation: 20.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.white, width: 1.0)),
            onPressed: () => _selectDate(context),
            child: Text('Select date'),
          ),
        ],
      ),
    );
  }

  Center getAcceptButtonControl(BuildContext context) {
    return Center(
        child: RaisedButton(
      color: ClanzColors.getSecColor(),
      elevation: 20.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.white, width: 1.0)),
      onPressed: () => _applyEvent(context),
      child: Text('GO!'),
    ));
  }

  _applyEvent(BuildContext context) {
    ClanzEvent newEvent = new ClanzEvent(
        name: _selectedName,
        date: _selectedDate,
        description: _selectedDescription,
        game: _selectedValue,
        participants: List<String>());
    dbService.registerEvent(newEvent);
    Navigator.pop(context);
  }
}
