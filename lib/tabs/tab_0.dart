import 'package:flutter/material.dart';
import 'package:news_app/widgets/player.dart';

class Tab0 extends StatefulWidget {
  Tab0({Key key}) : super(key: key);

  @override
  _Tab0State createState() => _Tab0State();
}

class _Tab0State extends State<Tab0> {
  @override
  Widget build(BuildContext context) {
    return Container(child: VideoApp());
  }
}
