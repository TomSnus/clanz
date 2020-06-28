import 'package:clanz/database/database_service.dart';
import 'package:clanz/models/clanz_event.dart';
import 'package:clanz/pages/events/event_registration.dart';
import 'package:clanz/presentaion/clanz_colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'event_tile.dart';

class EventPage extends StatelessWidget {
  EventRegistrationPageRoute eventPageRoute = new EventRegistrationPageRoute();

  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => EventPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: getFloatingActionButton(context),
      body: StreamProvider<List<ClanzEvent>>.value(
        value: DatabaseService().events,
        child: Scaffold(
          body: EventList(),
        ),
      ),
    );
  }

  FloatingActionButton getFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ClanzColors.getPrimaryColor(),
      elevation: 20.0,
      onPressed: () {
        Navigator.of(context).push(eventPageRoute);
      },
      child: Icon(
        Icons.add,
        color: ClanzColors.getSecColor(),
      ),
      heroTag: 'eventTag',
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
        itemExtent: 200.0,
        itemCount: events.length,
        itemBuilder: (context, index) {
          return EventTile(event: events[index]);
        });

    //return Scaffold();
  }
}
