import 'package:flutter/material.dart';
import 'package:news_app/blocs/obstetrics_data_bloc.dart';
import 'package:news_app/widgets/ob_category_tab_list.dart';
import 'package:news_app/widgets/loading_shimmer.dart';
import 'package:provider/provider.dart' as provider;

class ObstetricsTab2 extends StatefulWidget {
  ObstetricsTab2({Key key}) : super(key: key);

  @override
  _ObstetricsTab2State createState() => _ObstetricsTab2State();
}

class _ObstetricsTab2State extends State<ObstetricsTab2> {
  List data = [];

  @override
  Widget build(BuildContext context) {
    final ObstetricsDataBloc ob =
        provider.Provider.of<ObstetricsDataBloc>(context);
    setState(() {
      data = ob.recentData.where((u) => u['category'].contains('Other')).toList();
    });

    return data.length == 0 ? LoadingWidget() : obCategoryTabList(data, 'obtab2');
  }
}
