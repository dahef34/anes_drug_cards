import 'package:flutter/material.dart';
import 'package:news_app/blocs/recent_bloc.dart';
import 'package:news_app/widgets/category_tab_list.dart';
import 'package:news_app/widgets/loading_shimmer.dart';
import 'package:provider/provider.dart' as provider;


class Tab8 extends StatefulWidget {
  const Tab8({Key key}) : super(key: key);

  @override
  _Tab8State createState() => _Tab8State();
}

class _Tab8State extends State<Tab8> {

  List data = [];

  @override
  Widget build(BuildContext context) {
    
    final RecentDataBloc rb = provider.Provider.of<RecentDataBloc>(context);
    setState(() {
      data = rb.recentData.where(
        (u) => u['category'].contains('Paralytics')
      ).toList();
    });
    
    return data.length == 0 
           ? LoadingWidget()
           : categoryTabList(data, 'tab8');
  } 
}
