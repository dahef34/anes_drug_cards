import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:news_app/blocs/user_bloc.dart';
import 'package:news_app/models/category_data.dart';
import 'package:news_app/models/config.dart';
import 'package:news_app/models/icons_data.dart';
import 'package:news_app/pages/comments.dart';
import 'package:news_app/utils/next_screen.dart';
import 'package:provider/provider.dart' as provider;
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatefulWidget {
  final String tag;
  final String category;
  final String date;
  final String description;
  final String imageUrl;
  final int loves;
  final String timestamp;
  final String title;

  DetailsPage(
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
  _DetailsPageState createState() => _DetailsPageState(
      this.tag,
      this.category,
      this.date,
      this.description,
      this.imageUrl,
      this.loves,
      this.timestamp,
      this.title);
}

class _DetailsPageState extends State<DetailsPage> {
  final String tag;
  final String category;
  final String date;
  final String description;
  final String imageUrl;
  final int loves;
  final String timestamp;
  final String title;

  _DetailsPageState(this.tag, this.category, this.date, this.description,
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

  void _handleShare(title) {
    Share.share(title,
        subject:
            'Check out this app to explore more. App link: https://play.google.com/store/apps/details?id=${Config().androidPacakageName}');
  }

  @override
  Widget build(BuildContext context) {
    final UserBloc ub = provider.Provider.of<UserBloc>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            //pinned: true,

            backgroundColor: Colors.white70,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: tag,
                child: Image(
                  image: CachedNetworkImageProvider(imageUrl),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.keyboard_backspace,
                size: 32,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              // IconButton(
              //   icon: Icon(
              //     Icons.share,
              //     size: 22,
              //     color: Colors.white,
              //   ),
              //   onPressed: () {
              //     _handleShare(title);
              //   },
              // ),
              SizedBox(
                width: 5,
              )
            ],
          ),
          SliverFillRemaining(
              hasScrollBody: true,
              fillOverscroll: false,
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
                                    color: categoryColors[
                                        categories.indexOf(category)]),
                                child: AnimatedPadding(
                                  duration: Duration(milliseconds: 1000),
                                  padding: EdgeInsets.only(
                                      left: 10,
                                      right: rightPaddingValue,
                                      top: 5,
                                      bottom: 5),
                                  child: Text(
                                    category,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                )),
                            Spacer(),
                            // IconButton(
                            //   icon: _buildLoveIcon(ub.uid),
                            //   onPressed: () {
                            //     ub.handleLoveIconClick(timestamp);
                            //   },
                            // ),
                            // IconButton(
                            //   icon: _buildBookmarkIcon(ub.uid),
                            //   onPressed: () {
                            //     ub.handleBookmarkIconClick(context, timestamp);
                            //   },
                            // )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.access_time,
                                size: 18, color: Colors.grey),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              date,
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w600),
                        ),
                        Divider(
                          color: categoryColors[categories.indexOf(category)],
                          endIndent: 280,
                          thickness: 2,
                        ),
                        Row(
                          children: <Widget>[
                            // Icon(Icons.favorite, size: 20, color: Colors.grey),
                            // SizedBox(
                            //   width: 6,
                            // ),
                            // StreamBuilder(
                            //   stream: FirebaseFirestore.instance.collection('contents').doc(timestamp).snapshots(),
                            //   builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snap) {
                            //     if (!snap.hasData) return _buildLoves(0);
                            //     try {
                            //       dynamic nested = snap.data.get(FieldPath(['loves']));
                            //       return _buildLoves(snap.data.data()['loves']);
                            //     } on StateError catch(e) {
                            //       return _buildLoves(0);
                            //     }
                            //   },
                            // ),
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
                        Html(
                          style: {
                            "*": Style(
                                fontSize: FontSize.medium,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[900])
                          },
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

  Widget _buildLoves(loves) {
    return Text(
      '${loves.toString()} People like this',
      style: TextStyle(color: Colors.black38, fontSize: 13),
    );
  }

  Widget _buildLoveIcon(uid) {
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snap) {
        if (!snap.hasData) return LoveIcon().normal;
        try {
          dynamic d = snap.data.get(FieldPath(['loved items']));
          if (d.contains(timestamp)) {
            return LoveIcon().bold;
          } else {
            return LoveIcon().normal;
          }
        } on StateError catch (e) {
          return LoveIcon().normal;
        }
      },
    );
  }

  Widget _buildBookmarkIcon(uid) {
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) return BookmarkIcon().normal;
        try {
          dynamic e = snapshot.data.get(FieldPath(['bookmarked items']));
          if (e.contains(timestamp)) {
            return BookmarkIcon().bold;
          } else {
            return BookmarkIcon().normal;
          }
        } on StateError catch (e) {
          return BookmarkIcon().normal;
        }
      },
    );
  }
}
