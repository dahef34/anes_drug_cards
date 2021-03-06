import 'package:flutter/material.dart';
import 'package:news_app/blocs/recent_bloc.dart';
import 'package:news_app/widgets/category_tab_list.dart';
import 'package:news_app/widgets/loading_shimmer.dart';
import 'package:provider/provider.dart' as provider;


class Tab7 extends StatefulWidget {
  const Tab7({Key key}) : super(key: key);

  @override
  _Tab7State createState() => _Tab7State();
}

class _Tab7State extends State<Tab7> {

  List data = [];

  @override
  Widget build(BuildContext context) {
    
    final RecentDataBloc rb = provider.Provider.of<RecentDataBloc>(context);
    setState(() {
      data = rb.recentData.where(
        (u) => u['category'].contains('Other')
      ).toList();
    });
    
    return data.length == 0 
           ? LoadingWidget()
           : categoryTabList(data, 'tab7');
  } 
}
