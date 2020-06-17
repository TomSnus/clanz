import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SubscribePage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => SubscribePage(),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SubscriptionPage());
  }
}

class SubscriptionPage extends StatefulWidget {
  final bool _isCsGoActive = false;

  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<SubscriptionPage> {
  List<Widget> contentViews;
  bool _isCsGoActive;

  @override
  void initState() {
    _isCsGoActive = widget._isCsGoActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget listview = getListView();
    return Scaffold(body: listview);
  }

  List<Widget> getContentList() {
    contentViews = <Widget>[
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
          trailing: new Icon(_isCsGoActive
              ? Icons.notifications_active
              : Icons.notifications_off),
          onTap: _toggleCSGO,
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

  Widget getListView() {
    return ListView.builder(
      itemCount: getContentList().length,
      itemBuilder: (context, index) {
        return getContentList().elementAt(index);
      },
    );
  }

  void _toggleCSGO() {
    setState(() {
      if (_isCsGoActive) {
        _isCsGoActive = false;
      } else {
        _isCsGoActive = true;
      }
    });
  }
}
