import 'package:clanz/database/database_service.dart';
import 'package:clanz/models/clanz_event.dart';
import 'package:clanz/pages/events/event_registration.dart';
import 'package:clanz/presentaion/clanz_colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'event_tile.dart';

class EventPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => EventPage(),
      );

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ClanzEvent>>.value(
      value: DatabaseService().events,
      child: Scaffold(
        body: EventList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ClanzColors.getPrimaryColor(),
          elevation: 20.0,
          onPressed: () {
            Navigator.of(context).push(new EventRegistrationPageRoute());
            /*
            Navigator.push(context,
                MaterialPageRoute(builder:
                (context) => EventRegistrationView()));
                */
          },
          child: Icon(
            Icons.add,
            color: ClanzColors.getSecColor(),
          ),
          heroTag: "demoTag",
        ),
      ),
    );
  }
}

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {



  @override
  Widget build(BuildContext context) {
    final events = Provider.of<List<ClanzEvent>>(context);
    if (events == null) {
      return CircularProgressIndicator(
        backgroundColor: Colors.red,
      );
    }
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return EventTile(event: events[index]);
      },
    );

    //return Scaffold();
  }
}
