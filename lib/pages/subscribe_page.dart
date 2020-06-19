import 'dart:js';

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

  DataRequiredForBuild({
    this.iscsgoEnabled,
    this.isLolEnabled,
    this.isDndEnabled,
  });
}

class SubscriptionPage extends StatefulWidget {
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<SubscriptionPage> {
  List<Widget> contentViews;
  bool _isCsGoActive = false;
  bool _isLolActive = false;

  DatabaseService dbService = DatabaseService();
  Future<DataRequiredForBuild> _dataRequiredForBuild;

  _SubscriptionState();

  Future<DataRequiredForBuild> _fetchAllData() async {
    return DataRequiredForBuild(
        iscsgoEnabled: await dbService.getGameSubscriptionState('csgo'),
        isLolEnabled: await dbService.getGameSubscriptionState('lol'));
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
          leading: const Icon(Icons.add_comment),
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
        color: Colors.blueGrey,
      ),
      Card(
        child: ListTile(
          leading: const Icon(CustomIcon.),
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
        color: Colors.grey[300],
      ),
      Card(
        child: ListTile(
          leading: const Icon(Icons.add_comment),
          title: Text('CS:GO'),
        ),
        color: Colors.blueGrey,
      ),
      Card(
        child: ListTile(
          leading: const Icon(Icons.add_comment),
          title: Text('CS:GO'),
        ),
        color: Colors.blueGrey,
      ),
      Card(
        child: ListTile(
          leading: const Icon(Icons.add_comment),
          title: Text('CS:GO'),
        ),
        color: Colors.blueGrey,
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
      dbService.updateSubscriptionData(game, toggle);
    });
  }

  bool getSubscriptionState(String game) {
    bool isSubscribed = false;
    dbService.getGameSubscriptionState(game).then((value) => {
          isSubscribed = value,
        });
    return isSubscribed;
  }

  void initSnapData(AsyncSnapshot<DataRequiredForBuild> snapshot) {
    _isCsGoActive = snapshot.data.iscsgoEnabled;
    _isLolActive = snapshot.data.isLolEnabled;
  }
}
