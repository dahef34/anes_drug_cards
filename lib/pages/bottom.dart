import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'package:news_app/pages/obstetrics.dart';

class BottomWidget extends StatefulWidget {
  BottomWidget({Key key}) : super(key: key);

  @override
  _BottomWidgetState createState() => _BottomWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _BottomWidgetState extends State<BottomWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ObstetricsPage(),
    Text(
      'Regional',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Drugs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Obstetrics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Regional',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
