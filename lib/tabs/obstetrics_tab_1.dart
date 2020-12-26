import 'package:flutter/material.dart';
import 'package:news_app/blocs/obstetrics_data_bloc.dart';
import 'package:news_app/widgets/ob_category_tab_list.dart';
import 'package:news_app/widgets/loading_shimmer.dart';
import 'package:provider/provider.dart' as provider;

class ObstetricsTab1 extends StatefulWidget {
  ObstetricsTab1({Key key}) : super(key: key);

  @override
  _ObstetricsTab1State createState() => _ObstetricsTab1State();
}

class _ObstetricsTab1State extends State<ObstetricsTab1> {
  List data = [];

  @override
  Widget build(BuildContext context) {
    final ObstetricsDataBloc ob =
        provider.Provider.of<ObstetricsDataBloc>(context);
    setState(() {
      data =
          ob.recentData.where((u) => u['category'].contains('Cesarean')).toList();
    });

    return data.length == 0 ? LoadingWidget() : obCategoryTabList(data, 'obtab1');
  }
}
