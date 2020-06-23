import 'dart:js';

import 'package:clanz/presentaion/custom_icon_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:clanz/database/database_service.dart';
import 'package:clanz/services/authentication.dart';

class SubscribePage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => SubscribePage(),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SubscriptionPage());
  }
}

class DataRequiredForBuild {
  bool iscsgoEnabled;
  bool isLolEnabled;
  bool isDndEnabled;
  bool isBookClubEnabled;

  DataRequiredForBuild({
    this.iscsgoEnabled,
    this.isLolEnabled,
    this.isDndEnabled,
    this.isBookClubEnabled,
  });
}

class SubscriptionPage extends StatefulWidget {
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<SubscriptionPage> {
  List<Widget> contentViews;

  DatabaseService dbService = DatabaseService();
  Future<DataRequiredForBuild> _dataRequiredForBuild;

  _SubscriptionState();

  Future<DataRequiredForBuild> _fetchAllData() async {
    return DataRequiredForBuild(
        iscsgoEnabled: await dbService.getGameSubscriptionState('csgo'),
        isLolEnabled: await dbService.getGameSubscriptionState('lol'),
        isDndEnabled: await dbService.getGameSubscriptionState('dnd'),
        isBookClubEnabled: await dbService.getGameSubscriptionState('buchklub'));
    //isDndEnabled: await dbService.getGameSubscriptionState('dnd'));
  }

  @override
  void initState() {
    super.initState();
    _dataRequiredForBuild = _fetchAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DataRequiredForBuild>(
        future: _dataRequiredForBuild,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? getListView(snapshot)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  /*
      @override
      Widget build(BuildContext context) {
        Widget listview = getListView();
        return Scaffold(body: listview);
      }
    */
  List<Widget> getContentList(AsyncSnapshot<DataRequiredForBuild> snapshot) {
    contentViews = <Widget>[
      Card(
        child: ListTile(
          leading: const Icon(CustomIcon.counter_strike),
          title: Text('CS:GO'),
          trailing: new CupertinoSwitch(
            trackColor: Colors.grey[300],
            onChanged: (bool value) {
              _toggle('csgo', value);
              snapshot.data.iscsgoEnabled = value;
              setState(() {});
            },
            value: snapshot.data.iscsgoEnabled,
          ),
        ),
      ),
      Card(
        child: ListTile(
          leading: const Icon(CustomIcon.icons8_league_of_legends,
              color: Colors.white),
          title: Text('LoL'),
          trailing: new CupertinoSwitch(
            trackColor: Colors.grey[300],
            onChanged: (bool value) {
              _toggle('lol', value);
              snapshot.data.isLolEnabled = value;
              setState(() {});
            },
            value: snapshot.data.isLolEnabled,
          ),
        ),
      ),
      Card(
        child: ListTile(
          leading: const Icon(CustomIcon.dnd, color: Colors.white),
          title: Text('D&D'),
          trailing: new CupertinoSwitch(
            trackColor: Colors.grey[300],
            onChanged: (bool value) {
              _toggle('dnd', value);
              snapshot.data.isDndEnabled = value;
              setState(() {});
            },
            value: snapshot.data.isDndEnabled,
          ),
        ),
      ),
      Card(
        child: ListTile(
          leading: const Icon(Icons.book),
          title: Text('BuchKlub'),
          trailing: new CupertinoSwitch(
            trackColor: Colors.grey[300],
            onChanged: (bool value) {
              _toggle('buchklub', value);
              snapshot.data.isBookClubEnabled = value;
              setState(() {});
            },
            value: snapshot.data.isBookClubEnabled,
          ),
        ),
      ),
    ];
    return contentViews;
  }

  Widget getListView(AsyncSnapshot<DataRequiredForBuild> snapshot) {
    return ListView.builder(
      itemCount: getContentList(snapshot).length,
      itemBuilder: (context, index) {
        return getContentList(snapshot).elementAt(index);
      },
    );
  }

  void _toggle(String game, bool toggle) {
    setState(() {
     // dbService.updateSubscriptionData(game, toggle);
    });
  }

  bool getSubscriptionState(String game) {
    bool isSubscribed = false;
    dbService.getGameSubscriptionState(game).then((value) => {
          isSubscribed = value,
        });
    return isSubscribed;
  }
}
