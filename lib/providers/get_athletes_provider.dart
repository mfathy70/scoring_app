import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetAtlete with ChangeNotifier {
  String name = 'Athlete Name';
  String? id;

  void searchAthlete(String id) async {
    var collection = FirebaseFirestore.instance.collection('Athletes');
    var docSnapshot = await collection.doc(id).get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var nameValue = data?['name'];
      var idValue = data?['id'];

      name = nameValue;
      id = idValue.toString();

      print(name);
    }

    notifyListeners();
  }

  void setScore(int score, int excScore, int diffScore, int floScore) async {
    var collection = FirebaseFirestore.instance.collection('Athletes');

    await collection.doc(id).update({
      "excScore": excScore,
      "diffScore": diffScore,
      "floScore": floScore
    }).then((value) => null);
    await collection.doc(id).update({"score": score}).then((value) => null);
    print(score);

    name = 'Athlete Name';
    id = null;
    notifyListeners();
  }
}
