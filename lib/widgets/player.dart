import 'package:flutter/material.dart';
import 'package:news_app/widgets/featured.dart';

class VideoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: <Widget>[
      Spacer(),
      Featured(),
      Spacer()
    ]));
  }
}
