import 'package:flutter/material.dart';
import 'package:news_app/blocs/recent_bloc.dart';
import 'package:news_app/widgets/category_tab_list.dart';
import 'package:news_app/widgets/loading_shimmer.dart';
import 'package:provider/provider.dart' as provider;


class Tab2 extends StatefulWidget {
  const Tab2({Key key}) : super(key: key);

  @override
  _Tab2State createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {

  List data = [];

  @override
  Widget build(BuildContext context) {
    
    final RecentDataBloc rb = provider.Provider.of<RecentDataBloc>(context);
    setState(() {
      data = rb.recentData.where(
        (u) => u['category'].contains('Volatile')
      ).toList();
    });
    
    return data.length == 0 
           ? LoadingWidget()
           : categoryTabList(data, 'tab2');
  } 
}
