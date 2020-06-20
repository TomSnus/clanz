import 'package:clanz/presentaion/clanz_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'clanz_user.dart';

class UserTile extends StatelessWidget {
  final ClanzUser user;
  const UserTile({this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            trailing: Text(user.rank),
            title: Text(user.name),
            subtitle: Text(user.email),
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
