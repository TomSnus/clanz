import 'package:clanz/models/clanz_event.dart';
import 'package:clanz/presentaion/clanz_colors.dart';
import 'package:clanz/ui/CustomIconFactory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EventTile extends StatelessWidget {
  final ClanzEvent event;
  final _hasJoined = false;
  final _buttonText = 'Join';
  const EventTile({this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      //color: ClanzColors.getSecColor(),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: ClanzColors.getSecColorDark(),
        ),
        child: Stack(
          children: <Widget>[
            getLeadingControl(event),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                event.name,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: _getJoinButton(),
            )
          ],
        ),
      ),
    );
  }

  Container getLeadingControl(ClanzEvent event) {
    return Container(
        child: CircleAvatar(
          child: Icon(
            CustomIconFactory().getIcon(event.icon),
            color: Colors.white,
          ),
          radius: 25.0,
          backgroundColor: ClanzColors.getSecColor(),
        ),
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 0,
                // offset: Offset(2, 2),
              ),
            ],
            border: new Border.all(
              color: ClanzColors.getSecColorLight(),
              width: 4.0,
            )));
  }

  Container getTrailingControl(ClanzEvent event) {
    return Container(
      child: Column(
        children: [
          Icon(CustomIconFactory().getIcon(event.icon)),
          Text(event.game)
        ],
      ),
    );
  }

  RaisedButton _getJoinButton() {
    return RaisedButton(
        onPressed: () {},
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        elevation: 20.0,
        padding: EdgeInsets.all(0.0),
        child: Text(_buttonText,
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold)));
  }

  _joinEvent() {}
}
