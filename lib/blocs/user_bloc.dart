import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_app/blocs/bookmark_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends ChangeNotifier {
  String _userName = 'Name';
  String _email = 'email';
  String _uid = 'uid';
  String _imageUrl =
      'http://icons.iconarchive.com/icons/papirus-team/papirus-status/512/avatar-default-icon.png';

  String get userName => _userName;
  String get email => _email;
  String get uid => _uid;
  String get imageUrl => _imageUrl;

  getUserData() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    _userName = sp.getString('name');
    _email = sp.getString('email');
    _uid = sp.getString('uid');
    _imageUrl = sp.getString('image url');
    notifyListeners();
  }

  handleLoveIconClick(timestamp) async {
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(_uid);
    final DocumentReference ref1 =
        FirebaseFirestore.instance.collection('contents').doc(timestamp);

    DocumentSnapshot snap = await ref.get();
    DocumentSnapshot snap1 = await ref1.get();

    try {
      dynamic d = snap.get('loved items');
      dynamic _loves = snap1.get('loves');

      if (d.contains(timestamp)) {
        List a = [timestamp];
        await ref.update({'loved items': FieldValue.arrayRemove(a)});
        ref1.update({'loves': _loves - 1});
      } else {
        d.add(timestamp);
        await ref.update({'loved items': FieldValue.arrayUnion(d)});
        ref1.update({'loves': _loves + 1});
      }
    } on StateError catch (e) {
      print(e);
    }

    // int _loves = snap1['loves'];
  }

  handleBookmarkIconClick(context, timestamp) async {
    final BookmarkBloc bb = Provider.of<BookmarkBloc>(context);
    final DocumentReference ref =
        FirebaseFirestore.instance.collection('users').doc(_uid);
    DocumentSnapshot snap = await ref.get();
    List d = snap.data()['bookmarked items'];

    if (d.contains(timestamp)) {
      List a = [timestamp];
      await ref.update({'bookmarked items': FieldValue.arrayRemove(a)});
    } else {
      d.add(timestamp);
      await ref.update({'bookmarked items': FieldValue.arrayUnion(d)});
    }
    bb.getData();
  }
}
