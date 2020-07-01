import 'package:clanz/database/database_service.dart';
import 'package:clanz/models/clanz_event.dart';
import 'package:clanz/models/clanz_user.dart';
import 'package:clanz/presentaion/clanz_colors.dart';
import 'package:clanz/ui/CustomIconFactory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class EventTile extends StatelessWidget {
  final ClanzEvent event;
  final _hasJoined = false;
  final _buttonText = 'Join';
  ClanzUser user;
  DatabaseService dbService = new DatabaseService();
  EventTile({this.event});

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<ClanzUser>(context);
    final users = Provider.of<List<ClanzUser>>(context);
    if (userId == null || users == null) {
      return CircularProgressIndicator(
        backgroundColor: Colors.red,
      );
    }
    user = userId;
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
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: _getParticipants(context, users),
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
        onPressed: () {
          _joinEvent();
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        elevation: 20.0,
        padding: EdgeInsets.all(0.0),
        child: Text(
          _hasUserJoined() ? _buttonText : 'Abmelden',
          style: _getButtonStyle(),
        ));
  }

  _joinEvent() {
    int flag = 1;
    if (_hasUserJoined()) {
      flag = 0;
    }
    dbService.joinEvent(event, user, flag);
  }

  bool _hasUserJoined() {
    return event.participants != null &&
        user != null &&
        event.participants.containsKey(user.uid) &&
        event.participants[user.uid] == 1;
  }

  TextStyle _getButtonStyle() {
    if (_hasUserJoined())
      return TextStyle(color: Colors.green, fontWeight: FontWeight.bold);
    return TextStyle(color: Colors.red, fontWeight: FontWeight.bold);
  }

  Widget _getCreator(BuildContext context) {
    String creator = 'Veranstalter: ';
    return new StreamBuilder(
        stream: dbService.userCollection.document(user.uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userDocument = snapshot.data;
          return new Text(creator + userDocument["name"]);
        });
  }

  Widget _getParticipants(BuildContext context, List<ClanzUser> users) {
    List<String> userIds = List();
    List<String> userNames = List();
    String participants = 'Teilnehmer:';
    event.participants.forEach((key, value) {
      if (value == 1) userIds.add(key);
    });
    users.forEach((element) {
      if (userIds.contains(element.uid)) userNames.add(element.name);
    });
    return Text(participants + userNames.toString());
  }
}
