import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class AnxietyProvider extends ChangeNotifier {
  double _healthAnxiety = 0.0;
  double _socialAnxiety = 0.0;
  double _anxiety = 0.0;

  double get healthAnxiety => _healthAnxiety;
  double get socialAnxiety => _socialAnxiety;
  double get anxiety => _anxiety;

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

  // getAnxietyValues() {
  //   DocumentSnapshot doc =    FirebaseFirestore.instance
  //   .collection('myCollection')
  //   .where('myField', isEqualTo: fieldValue)
  //   .snapshots()
  //   .map((querySnapshot) => querySnapshot.docs.first);
  // }

  factory AnxietyProvider() => AnxietyProvider._();

  AnxietyProvider._();
}
