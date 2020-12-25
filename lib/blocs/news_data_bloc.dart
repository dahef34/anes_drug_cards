import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/icons_data.dart';

class NewsDataBloc extends ChangeNotifier {

  
  List _data = [];
  Icon _loveIcon = LoveIcon().normal;
  Icon _bookmarIcon = BookmarkIcon().normal;



  

  NewsDataBloc() {
    getData();
  }



  List get data => _data;
  Icon get loveIcon => _loveIcon;
  Icon get bookmarkIcon => _bookmarIcon;




  Future getData() async {
    QuerySnapshot snap = await FirebaseFirestore.instance.collection('contents').get();
    var x = snap.docs;
    x.removeWhere((item) => item['category'] != 'Updates');
    _data.clear();
    x.forEach((f) {
      _data.add(f);
    });
    //_data.shuffle();
  }


}
