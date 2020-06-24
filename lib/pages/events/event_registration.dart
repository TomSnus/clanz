import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

class EventRegistrationPageRoute extends CupertinoPageRoute {
  EventRegistrationPageRoute()
      : super(builder: (BuildContext context) => new EventRegistrationView());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(
        opacity: animation, child: new EventRegistrationView());
  }
}

class EventRegistrationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Event'),
      ),
      body: Center(
        child: Hero(
          tag: "demoTag",
          child: Icon(
            Icons.thumb_up,
            size: 200.0,
            color: Colors.blue,
          ),
          flightShuttleBuilder:
              (flightContext, animation, direction, fromContext, toContext) {
            if (direction == HeroFlightDirection.push) {
              return Icon(
                Icons.favorite,
                size: 150.0,
                color: Colors.blue,
              );
            } else if (direction == HeroFlightDirection.pop) {
              return Icon(
                Icons.favorite,
                size: 70.0,
                color: Colors.blue,
              );
            }
          },
          placeholderBuilder: (context, size, widget) {
            return Container(
              height: 200.0,
              width: 200.0,
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
