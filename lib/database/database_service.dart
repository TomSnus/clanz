import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  String _uid;
  final CollectionReference gamesCollection =
      Firestore.instance.collection('games');

  Future<String> _getUserId() async {
    if(_uid == null){
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    _uid = user.uid;
    }
    return _uid;
  }

  Future updateSubscriptionData(String game, int enabled) async {
    return await gamesCollection
        .document(game)
        .collection('subscriber')
        .document(await _getUserId())
        .setData({
      'enabled': enabled,
    });
  }

  int get gameSubscriptionState(String game){
    return gamesCollection.document(game).collection('subscriber').document(await _getUserId()).get();
  }
}
