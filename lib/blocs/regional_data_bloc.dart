import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegionalDataBloc extends ChangeNotifier {
  List _data = [];

  regionalDataBloc() {
    getData();
  }

  List get data => _data;

  Future getData() async {
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection('regional').get();
    var x = snap.docs;
    x.removeWhere((item) => item['category'] != 'Updates');
    _data.clear();
    x.forEach((f) {
      _data.add(f);
    });
    //_data.shuffle();
  }
}
