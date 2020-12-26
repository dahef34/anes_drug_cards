import 'package:flutter/material.dart';
import 'package:news_app/blocs/obstetrics_data_bloc.dart';
import 'package:news_app/widgets/ob_category_tab_list.dart';
import 'package:news_app/widgets/loading_shimmer.dart';
import 'package:provider/provider.dart' as provider;

class ObstetricsTab0 extends StatefulWidget {
  ObstetricsTab0({Key key}) : super(key: key);

  @override
  _ObstetricsTab0State createState() => _ObstetricsTab0State();
}

class _ObstetricsTab0State extends State<ObstetricsTab0> {
  List data = [];

  @override
  Widget build(BuildContext context) {
    final ObstetricsDataBloc ob =
        provider.Provider.of<ObstetricsDataBloc>(context);
    setState(() {
      data = ob.recentData.where((u) => u['category'].contains('Labor')).toList();
    });

    return data.length == 0 ? LoadingWidget() : obCategoryTabList(data, 'obtab0');
  }
}
