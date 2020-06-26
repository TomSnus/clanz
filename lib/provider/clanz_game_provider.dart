import 'package:clanz/models/clanz_game.dart';
import 'package:flutter/widgets.dart';

class ClanzGameProvider with ChangeNotifier {
  ClanzGame document;

  ClanzGameProvider() {
    initFormFields(); // will perform network request
  }

  void initFormFields() async {
    /*
    Map results = initializeDataFromApi(id: id);
    try {
      document = ClanzGame.fromJson(results['data']);
    } catch (e) {
      // Handle Exceptions
    }
    notifyListeners(); 
    */
  }}