import 'package:flutter/material.dart';
import 'package:news_app/blocs/comments_bloc.dart';
import 'package:news_app/blocs/internet_bloc.dart';
import 'package:news_app/utils/empty.dart';
import 'package:news_app/utils/snacbar.dart';
import 'package:news_app/utils/toast.dart';
import 'package:provider/provider.dart' as provider;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news_app/blocs/user_bloc.dart';

class CommentsPage extends StatefulWidget {
  final String category;
  final String timestamp;
  const CommentsPage(
      {Key key, @required this.category, @required this.timestamp})
      : super(key: key);

  @override
  _CommentsPageState createState() =>
      _CommentsPageState(this.category, this.timestamp);
}

class _CommentsPageState extends State<CommentsPage> {
  String category;
  String timestamp;
  _CommentsPageState(this.category, this.timestamp);

  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var textFieldCtrl = TextEditingController();
  String comment;

  void handleSubmit() async {
    final CommentsBloc cb =
        provider.Provider.of<CommentsBloc>(context, listen: false);
    final InternetBloc ib =
        provider.Provider.of<InternetBloc>(context, listen: false);
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      await ib.checkInternet();
      if (ib.hasInternet == false) {
        openSnacbar(scaffoldKey, 'No internet available');
      } else {
        await cb.saveNewComment(timestamp, comment);
        textFieldCtrl.clear();
        FocusScope.of(context).requestFocus(new FocusNode());
      }
    }
  }

  void handleDelete(uid, timestamp2) async {
    final InternetBloc ib =
        provider.Provider.of<InternetBloc>(context, listen: false);
    final CommentsBloc cb =
        provider.Provider.of<CommentsBloc>(context, listen: false);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Delete?',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            content: Text('Want to delete this note?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes'),
                onPressed: () async {
                  Navigator.pop(context);
                  await ib.checkInternet();
                  if (ib.hasInternet == false) {
                    openToast(context, 'No internet connection');
                  } else {
                    final SharedPreferences sp =
                        await SharedPreferences.getInstance();
                    String _uid = sp.getString('uid');
                    if (uid != _uid) {
                      openToast(context, 'You can not delete others note');
                    } else {
                      await cb.deleteComment(timestamp, uid, timestamp2);
                      openToast(context, 'Deleted Successfully');
                    }
                  }
                },
              ),
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final CommentsBloc cb =
        provider.Provider.of<CommentsBloc>(context, listen: false);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        elevation: 1,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: FutureBuilder(
            future: cb.getData(timestamp),
            builder: (context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return emptyPage(
                      Icons.signal_wifi_off, 'No internet connection');
                case ConnectionState.waiting:
                  return Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.deepPurpleAccent,
                  ));
                default:
                  if (snapshot.hasError) return emptyPage(Icons.error, 'Error');
                  if (snapshot.data.isEmpty)
                    return emptyPage(Icons.message, 'No notes yet!');
                  else
                    return _buildList(snapshot.data);
              }
            },
          )),
          Divider(
            height: 1,
            color: Colors.black26,
          ),
          SafeArea(
            child: Container(
              height: 65,
              padding: EdgeInsets.only(top: 8, bottom: 10, right: 20, left: 20),
              width: double.infinity,
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25)),
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 0),
                        contentPadding:
                            EdgeInsets.only(left: 15, top: 10, right: 5),
                        border: InputBorder.none,
                        hintText: 'Write a note',
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.grey[700],
                            size: 20,
                          ),
                          onPressed: () {
                            handleSubmit();
                          },
                        )),
                    controller: textFieldCtrl,
                    onSaved: (String value) {
                      setState(() {
                        this.comment = value;
                      });
                    },
                    validator: (value) {
                      if (value.length == 0) return 'nullllll';
                      return null;
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildList(snap) {
    List d = snap;
    final UserBloc ub = provider.Provider.of<UserBloc>(context, listen: false);
    d.removeWhere((item) => item['uid'] != ub.uid);
    d.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
    return ListView.builder(
      padding: EdgeInsets.all(15),
      itemCount: d.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                children: <Widget>[
                  // Container(
                  //   alignment: Alignment.bottomLeft,
                  //   child: CircleAvatar(
                  //     radius: 25,
                  //     backgroundColor: Colors.grey[200],
                  //     backgroundImage: CachedNetworkImageProvider(d[index]['image url']),
                  //
                  //   ),
                  // ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              left: 10, top: 10, right: 10, bottom: 3),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Text(d[index]['name'],
                              // maxLines: 1,
                              // overflow: TextOverflow.ellipsis,
                              // style: TextStyle(fontSize: 13, color: Colors.grey[900], fontWeight: FontWeight.w600),),

                              Text(
                                d[index]['comment'],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            d[index]['date'],
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
          onLongPress: () {
            handleDelete(d[index]['uid'], d[index]['timestamp']);
          },
        );
      },
    );
  }
}
