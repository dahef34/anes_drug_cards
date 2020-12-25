import 'package:flutter/material.dart';
import 'package:news_app/blocs/recent_bloc.dart';
import 'package:news_app/widgets/category_tab_list.dart';
import 'package:news_app/widgets/loading_shimmer.dart';
import 'package:provider/provider.dart' as provider;


class Tab9 extends StatefulWidget {
  const Tab9({Key key}) : super(key: key);

  @override
  _Tab9State createState() => _Tab9State();
}

class _Tab9State extends State<Tab9> {

  List data = [];

  @override
  Widget build(BuildContext context) {
    
    final RecentDataBloc rb = provider.Provider.of<RecentDataBloc>(context);
    setState(() {
      data = rb.recentData.where(
        (u) => u['category'].contains('Reversals')
      ).toList();
    });
    
    return data.length == 0 
           ? LoadingWidget()
           : categoryTabList(data, 'tab9');
  } 
}
