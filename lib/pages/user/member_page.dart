import 'package:clanz/database/database_service.dart';
import 'package:clanz/pages/user/clanz_user.dart';
import 'package:clanz/pages/user/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MemberPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => MemberPage(),
      );

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ClanzUser>>.value(
      value: DatabaseService().clanzUsers,
      child: Scaffold(
         body: UserList(),
      ),
    );
  }
}

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<ClanzUser>>(context);
    /*
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UserTile(user: users[index]);
      },
    );
    */
    return Scaffold();
  }
}
