import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecommandedDataBloc extends ChangeNotifier {
  
  
  

  RecommandedDataBloc(){
    getData();
  }

  List _data = [];
  List get data => _data;
    

  


  Future getData() async {
    QuerySnapshot snap = await FirebaseFirestore.instance.collection('contents').get();
    var x = snap.docs;
    _data.clear();
    x.forEach((f) {
      _data.add(f);
    });
    _data.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));
    notifyListeners();
    

    
  }
}
