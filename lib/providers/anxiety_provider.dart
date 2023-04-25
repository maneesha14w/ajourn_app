import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MyProvider extends ChangeNotifier {
  String currentUid = '';

  bool isEntryBtnDisabled = true;
  bool isCbtEntryBtnDisabled = true;

  double _healthAnxiety = 0.0;
  double _socialAnxiety = 0.0;
  double _anxiety = 0.0;

  double get healthAnxiety => _healthAnxiety;
  double get socialAnxiety => _socialAnxiety;
  double get anxiety => _anxiety;

  late Stream<QuerySnapshot> _myStream;

  Stream<QuerySnapshot> get myStream => _myStream;

  set myStream(Stream<QuerySnapshot> value) {
    _myStream = value;
    notifyListeners();
  }

  set healthAnxiety(double value) {
    _healthAnxiety = value;
    notifyListeners();
  }

  set socialAnxiety(double value) {
    _socialAnxiety = value;
    notifyListeners();
  }

  set anxiety(double value) {
    _anxiety = value;
    notifyListeners();
  }

  factory MyProvider() => MyProvider._();

  MyProvider._();
}
