import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  String _uid;
  final CollectionReference gamesCollection =
      Firestore.instance.collection('games');

  Future<String> _getUserId() async {
    if (_uid == null) {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      _uid = user.uid;
    }
    return _uid;
  }

  Future updateSubscriptionData(String game, bool enabled) async {
    return await gamesCollection
        .document(game)
        .collection('subscriber')
        .document(await _getUserId())
        .setData({
      'enabled': enabled,
    });
  }

  Future<bool> getGameSubscriptionState(String game) async {
    bool _value = false;
    String uid = await _getUserId();
    await gamesCollection
        .document(game)
        .collection('subscriber')
        .document(uid)
        .get()
        .then(
            (value) => {if (value.exists) _value = value.data['enabled']});
    return _value;
  }
}
