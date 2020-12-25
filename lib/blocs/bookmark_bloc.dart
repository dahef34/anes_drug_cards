import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class BookmarkBloc extends ChangeNotifier {

  List _data = [];
  List get data => _data;
  

  

  void getData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String _uid = sp.getString('uid');

    final DocumentReference ref = FirebaseFirestore.instance.collection('users').doc(_uid);
    DocumentSnapshot snap = await ref.get();
    List d = snap.data()['bookmarked items'];
    _data.clear();

    FirebaseFirestore.instance
        .collection('contents')
        .get()
        .then((QuerySnapshot snap) {
      var x = snap.docs;
      for (var item in x) {
        if (d.contains(item['timestamp'])) {
          _data.add(item);
        }
      }
      notifyListeners();
    });
  
  }
}
