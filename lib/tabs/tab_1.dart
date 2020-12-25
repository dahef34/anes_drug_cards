import 'package:flutter/material.dart';
import 'package:news_app/blocs/recent_bloc.dart';
import 'package:news_app/widgets/category_tab_list.dart';
import 'package:news_app/widgets/loading_shimmer.dart';
import 'package:provider/provider.dart' as provider;


class Tab1 extends StatefulWidget {
  const Tab1({Key key}) : super(key: key);

  @override
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {

  List data = [];

  @override
  Widget build(BuildContext context) {
    
    final RecentDataBloc rb = provider.Provider.of<RecentDataBloc>(context);
    setState(() {
      data = rb.recentData.where(
        (u) => u['category'].contains('Induction')
      ).toList();
    });
    
    return data.length == 0 
           ? LoadingWidget()
           : categoryTabList(data, 'tab1');
  } 
}
