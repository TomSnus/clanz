import 'package:clanz/pages/user/clanz_user.dart';
import 'package:clanz/pages/user/clanz_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  String _uid;
  final CollectionReference gamesCollection =
      Firestore.instance.collection('games');
  final CollectionReference userCollection =
      Firestore.instance.collection('user');

  Future<String> _getUserId() async {
    if (_uid == null) {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      _uid = user.uid;
    }
    return _uid;
  }

  Future<bool> getIsUserRegistered() async {
    if (this._uid == null) await _getUserId();
    DocumentSnapshot userEntry = await userCollection.document(_uid).get();
    if (userEntry == null || !userEntry.exists) return false;
    return true;
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
        .then((value) => {if (value.exists) _value = value.data['enabled']});
    return _value;
  }

  void registerUser(String email, String name) {
    String rank = 'rank';
    _getUserId().then((value) => {
          userCollection
              .document(value)
              .setData({'uid': value, 'email': email, 'name': name, 'rank': rank}),
        });
  }


  List<ClanzUser> _userListFromSnapShot(QuerySnapshot snap){
    return snap.documents.map((doc) {
      ClanzUser(
          uid: doc.data['uid'] ?? '',
          name: doc.data['name'] ?? '',
          email: doc.data['email'] ?? '',
          rank: doc.data['rank'] ?? '');
    }).toList();
  }

  Stream<List<ClanzUser>> get clanzUsers{
    return userCollection.snapshots().map(_userListFromSnapShot);
  }
}
