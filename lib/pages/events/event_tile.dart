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
            Align(alignment: Alignment.bottomRight, child: Text('dummer Tom'))
          ],
        ),
      ),
    );
  }

  Container getLeadingControl(ClanzEvent event) {
    return Container(
      child: Column(
        children: [
          CircleAvatar(
            child: Icon(CustomIconFactory().getIcon(event.icon)),
            radius: 25.0,
            backgroundColor: ClanzColors.getSecColor(),
          ),
        ],
      ),
    );
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
}
