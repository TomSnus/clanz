import 'package:clanz/models/clanz_event.dart';
import 'package:clanz/models/clanz_game.dart';
import 'package:clanz/models/clanz_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  String _uid;
  final CollectionReference gamesCollection =
      Firestore.instance.collection('games');
  final CollectionReference userCollection =
      Firestore.instance.collection('user');
  final CollectionReference eventCollection =
      Firestore.instance.collection('events');

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> getUserId() async {
    if (_uid == null) {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      _uid = user.uid;
    }
    return _uid;
  }

  ClanzUser _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? ClanzUser(uid: user.uid) : null;
  }

  Stream<ClanzUser> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future<bool> getIsUserRegistered() async {
    if (this._uid == null) await getUserId();
    DocumentSnapshot userEntry = await userCollection.document(_uid).get();
    if (userEntry == null || !userEntry.exists) return false;
    return true;
  }

  Future updateSubscriptionData(
      String userId, String game, bool enabled) async {
    return await gamesCollection.document(game).setData({
      'subscriber': {userId: enabled},
    }, merge: true);
  }

  Future<bool> getGameSubscriptionState(String game) async {
    bool _value = false;
    String uid = await getUserId();
    await gamesCollection
        .document(game)
        .collection('subscriber')
        .document(uid)
        .get()
        .then((value) => {if (value.exists) _value = value.data['enabled']});
    return _value;
  }

  void registerUser(String email, String name) {
    String rank = 'member';
    getUserId().then((value) => {
          userCollection.document(value).setData(
              {'uid': value, 'email': email, 'name': name, 'rank': rank}),
          gamesCollection.reference().getDocuments().then((value) => {
                value.documents.forEach((element) {
                  _initGameData(element, value);
                })
              }),
        });
  }

  List<ClanzUser> _userListFromSnapShot(QuerySnapshot snap) {
    return snap.documents.map((doc) {
      return ClanzUser(
          uid: doc.data['uid'] ?? '',
          name: doc.data['name'] ?? '',
          email: doc.data['email'] ?? '',
          rank: doc.data['rank'] ?? '');
    }).toList();
  }

  Stream<List<ClanzUser>> get clanzUsers {
    return userCollection.snapshots().map(_userListFromSnapShot);
  }

  //game data
  CollectionReference _getGameSubscriberCollection(String game) {
    return Firestore.instance
        .collection('games')
        .document(game)
        .collection('subscriber');
  }

  Future<Map<String, bool>> _getGameSubscriptionUsers(String game) async {
    final values = Map<String, bool>();
    await _getGameSubscriberCollection(game).getDocuments().then((value) => {
          value.documents
              .map((e) => {values[e.documentID] = e.data['enabled']})
              .toList()
        });
    return values;
  }

  List<ClanzGame> _subscriberList(QuerySnapshot snap) {
    Map<String, bool> defaultMap = {
      '': false,
    };
    return snap.documents.map((doc) {
      return ClanzGame(
          name: doc.data['name'] ?? '',
          icon: doc.data['icon'] ?? '',
          subscriber: doc.data['subscriber'] ?? defaultMap);
    }).toList();
  }

  Stream<List<ClanzGame>> get games {
    return gamesCollection.snapshots().map(_subscriberList);
  }

  void _initGameData(DocumentSnapshot game, QuerySnapshot userId) {
    gamesCollection.document(game.documentID).updateData({
      'subscriber': {userId: false}
    });
  }

  //event data
  List<ClanzEvent> _eventList(QuerySnapshot snap) {
    List<ClanzEvent> _list = List();
    List<DocumentSnapshot> eventDocs = snap.documents;
    for (int _i = 0; _i < eventDocs.length; _i++) {
      ClanzEvent event = ClanzEvent.fromJson(eventDocs[_i].data);
      event.id = eventDocs[_i].documentID;
      _list.add(event);
    }
    return _list;
  }

  Stream<List<ClanzEvent>> get events {
    return eventCollection.snapshots().map(_eventList);
  }

  void registerEvent(ClanzEvent event) {
    Firestore.instance.runTransaction((Transaction tx) async {
      var _result = await eventCollection.add(event.toJson());
    });
  }

  void joinEvent(ClanzEvent event, ClanzUser user, int flag) {
    int enabled = 1;
    eventCollection.document(event.id).setData({
      'participants': {user.uid: flag},
    }, merge: true);
  }
}
