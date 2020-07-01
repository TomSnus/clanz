import 'package:clanz/database/database_service.dart';
import 'package:clanz/pages/calendar_page.dart';
import 'package:clanz/pages/home_page.dart';
import 'package:clanz/pages/profile_page.dart';
import 'package:clanz/pages/subscribe_page.dart';
import 'package:clanz/services/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'events/events_page.dart';
import 'games/subscribe_page2.dart';
import 'user/member_page.dart';

enum BottomNavigationDemoType {
  withLabels,
  withoutLabels,
}

class BottomNavigationDemo extends StatefulWidget {
  const BottomNavigationDemo(
      {Key key, this.auth, this.userId, this.logoutCallback, this.type})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final BottomNavigationDemoType type;

  @override
  _BottomNavigationDemoState createState() => _BottomNavigationDemoState();
}

class _BottomNavigationDemoState extends State<BottomNavigationDemo>
    with TickerProviderStateMixin {
  _BottomNavigationDemoState({this.auth, this.userId});

  int _currentIndex = 0;
  final BaseAuth auth;
  final String userId;
  List<_NavigationIconView> _navigationViews;

  String _title(BuildContext context) {
    switch (widget.type) {
      case BottomNavigationDemoType.withLabels:
        return widget.userId;
      case BottomNavigationDemoType.withoutLabels:
        return 'title2';
    }
    return '';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_navigationViews == null) {
      _navigationViews = <_NavigationIconView>[
        _NavigationIconView(
          page: EventPage(),
          icon: const Icon(Entypo.game_controller),
          title: 'Events',
          vsync: this,
          //color: Colors.blueGrey,
        ),
        _NavigationIconView(
          page: CalendarPage(),
          icon: const Icon(Icons.calendar_today),
          title: 'Calendar',
          vsync: this,
          //color: Colors.lightGreen,
        ),
        _NavigationIconView(
          page: Container(),
          icon: const Icon(Icons.account_circle),
          title: 'Account',
          vsync: this,
          //color: Colors.lightBlue,
        ),
        _NavigationIconView(
          page: MemberPage(),
          icon: const Icon(Icons.people),
          title: 'Member',
          vsync: this,
          //color: Colors.amber,
        ),
        _NavigationIconView(
          page: SubscribePage2(),
          icon: const Icon(Icons.notifications),
          title: 'Notifications',
          vsync: this,
          //color: Colors.cyan,
        ),
      ];

      _navigationViews[_currentIndex].controller.value = 1;
    }
  }

  @override
  void dispose() {
    for (final view in _navigationViews) {
      view.controller.dispose();
    }
    super.dispose();
  }

  Widget _buildTransitionsStack() {
    final transitions = <FadeTransition>[];

    for (final view in _navigationViews) {
      transitions.add(view.transition(context));
    }

    transitions.sort((a, b) {
      final aAnimation = a.opacity;
      final bAnimation = b.opacity;
      final aValue = aAnimation.value;
      final bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return Stack(children: transitions);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    var bottomNavigationBarItems = _navigationViews
        .map<BottomNavigationBarItem>((navigationView) => navigationView.item)
        .toList();
    if (widget.type == BottomNavigationDemoType.withLabels) {
      bottomNavigationBarItems =
          bottomNavigationBarItems.sublist(0, _navigationViews.length);
      _currentIndex =
          _currentIndex.clamp(0, bottomNavigationBarItems.length - 1).toInt();
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(_navigationViews.elementAt(_currentIndex).title),
        backgroundColor: _navigationViews.elementAt(_currentIndex).color,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          for (final tabItem in _navigationViews) tabItem.page,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels:
            widget.type == BottomNavigationDemoType.withLabels,
        items: bottomNavigationBarItems,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: textTheme.caption.fontSize,
        unselectedFontSize: textTheme.caption.fontSize,
        onTap: (int index) => setState(() => _currentIndex = index),
        //selectedItemColor: colorScheme.onPrimary,
        // unselectedItemColor: colorScheme.onPrimary.withOpacity(0.38),
        // backgroundColor: _navigationViews.elementAt(_currentIndex).color,
      ),
    );
  }
}

class _NavigationIconView {
  _NavigationIconView({
    this.title,
    this.icon,
    this.page,
    this.color,
    TickerProvider vsync,
  })  : item = BottomNavigationBarItem(
          icon: icon,
          title: Text(title),
        ),
        controller = AnimationController(
          duration: Duration(seconds: 2),
          vsync: vsync,
        ) {
    _animation = controller.drive(CurveTween(
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    ));
  }

  final MaterialColor color;
  final String title;
  final Widget icon;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  final Widget page;
  Animation<double> _animation;

  FadeTransition transition(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Stack(
        children: [
          ExcludeSemantics(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/demos/bottom_navigation_background.png',
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: IconTheme(
              data: const IconThemeData(
                //color: Colors.white,
                size: 80,
              ),
              child: Semantics(
                label: 'Title',
                child: icon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
