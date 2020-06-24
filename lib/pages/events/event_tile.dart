

import 'package:clanz/models/clanz_event.dart';
import 'package:clanz/presentaion/clanz_colors.dart';
import 'package:clanz/ui/CustomIconFactory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EventTile extends StatelessWidget {
  final ClanzEvent event;
  const EventTile({this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            trailing: Icon(CustomIconFactory().getIcon(event.icon)),
            title: Text(event.name) ?? '',
            subtitle: Text(event.game ?? ''),
            isThreeLine: true,
            
            leading: CircleAvatar(
              child: Icon(Icons.sentiment_very_satisfied, color: Colors.white,),
              radius: 25.0,
              backgroundColor: ClanzColors.getSecColor(),
            ),
          ),
        ));
  }
}
