import 'package:news_app/models/category_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/pages/ob_details.dart';
import 'package:news_app/utils/next_screen.dart';

Widget obCategoryTabList(d, tag) {
  return ListView.separated(
    padding: EdgeInsets.all(15),
    itemCount: d.length,
    separatorBuilder: (BuildContext context, int index) {
      return SizedBox(
        height: 20,
      );
    },
    itemBuilder: (BuildContext context, int index) {
      return InkWell(
        child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: obCategoryColors[obCategories.indexOf(d[index]['category'])],
                      blurRadius: 5,
                      offset: Offset(1, 1))
                ]),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      flex: 5,
                      child: Column(
                        children: <Widget>[
                          Text(
                            d[index]['title'],
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500),
                            maxLines: 4,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Hero(
                        tag: '$tag$index',
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey[200],
                                    blurRadius: 1,
                                    offset: Offset(1, 1))
                              ],
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      d[index]['image url']),
                                  fit: BoxFit.scaleDown)),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )),
        onTap: () {
          nextScreen(
              context,
              ObDetailsPage(
                tag: '$tag$index',
                category: d[index]['category'],
                date: d[index]['date'],
                description: d[index]['description'],
                imageUrl: d[index]['image url'],
                loves: d[index]['loves'],
                timestamp: d[index]['timestamp'],
                title: d[index]['title'],
              ));
        },
      );
    },
  );
}
