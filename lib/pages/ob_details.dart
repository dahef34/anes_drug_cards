import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:news_app/models/category_data.dart';
import 'package:news_app/pages/comments.dart';
import 'package:news_app/utils/next_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ObDetailsPage extends StatefulWidget {
  final String tag;
  final String category;
  final String date;
  final String description;
  final String imageUrl;
  final int loves;
  final String timestamp;
  final String title;

  ObDetailsPage(
      {Key key,
      @required this.tag,
      this.category,
      this.date,
      this.description,
      this.imageUrl,
      this.loves,
      this.timestamp,
      this.title})
      : super(key: key);

  @override
  _ObDetailsPageState createState() => _ObDetailsPageState(
      this.tag,
      this.category,
      this.date,
      this.description,
      this.imageUrl,
      this.loves,
      this.timestamp,
      this.title);
}

class _ObDetailsPageState extends State<ObDetailsPage> {
  final String tag;
  final String category;
  final String date;
  final String description;
  final String imageUrl;
  final int loves;
  final String timestamp;
  final String title;

  _ObDetailsPageState(this.tag, this.category, this.date, this.description,
      this.imageUrl, this.loves, this.timestamp, this.title);

  double rightPaddingValue = 140;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      setState(() {
        rightPaddingValue = 10;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: false,
            backgroundColor: obCategoryColors[obCategories.indexOf(category)],
            expandedHeight: 200,
            collapsedHeight: 60,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.fromLTRB(0, 80, 0, 0),
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              title: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(height: 40,
                child: 
                      Text(title, textAlign: TextAlign.center, style: 
                      TextStyle(fontSize: 14))),
              ),
              background: Hero(
                tag: tag,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 60),
                  child: Image(
                    image: CachedNetworkImageProvider(imageUrl),
                    fit: BoxFit.scaleDown,
                    //color: Colors.white,
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.keyboard_backspace,
                size: 32,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: obCategoryColors[
                                        obCategories.indexOf(category)]),
                                child: AnimatedPadding(
                                  duration: Duration(milliseconds: 1000),
                                  padding: EdgeInsets.only(
                                      left: 10,
                                      right: rightPaddingValue,
                                      top: 5,
                                      bottom: 5),
                                  child: Text(
                                    category,
                                    style: TextStyle(fontSize: 13, color: Colors.white),
                                  ),
                                )),
                            Spacer(),
                            FlatButton.icon(
                              color: Colors.blue[300],
                              icon: Icon(Icons.comment,
                                  color: Colors.black87, size: 20),
                              label: Text('Notes',
                                  style: TextStyle(color: Colors.black87)),
                              onPressed: () {
                                nextScreen(
                                    context,
                                    CommentsPage(
                                        category: category,
                                        timestamp: timestamp));
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Html(
                          data: '''$description''',
                          onLinkTap: (url) async {
                            await launch(url);
                          },
                        ),
                      ],
                    ),
                  ),
                  //Others(
                  // timestamp: timestamp,
                  //)
                ],
              )))
        ],
      ),
    );
  }
}
