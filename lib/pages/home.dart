import 'dart:ui';
import 'package:badges/badges.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:news_app/blocs/bookmark_bloc.dart';
import 'package:news_app/blocs/internet_bloc.dart';
import 'package:news_app/blocs/notification_bloc.dart';
import 'package:news_app/blocs/user_bloc.dart';
import 'package:news_app/models/category_data.dart';
import 'package:news_app/pages/notification.dart';
import 'package:news_app/pages/search_page.dart';
import 'package:news_app/tabs/tab_0.dart';
import 'package:news_app/tabs/tab_1.dart';
import 'package:news_app/tabs/tab_2.dart';
import 'package:news_app/tabs/tab_3.dart';
import 'package:news_app/tabs/tab_4.dart';
import 'package:news_app/tabs/tab_5.dart';
import 'package:news_app/tabs/tab_6.dart';
import 'package:news_app/tabs/tab_7.dart';
import 'package:news_app/tabs/tab_8.dart';
import 'package:news_app/tabs/tab_9.dart';
import 'package:news_app/utils/next_screen.dart';
import 'package:news_app/widgets/drawer.dart';
import 'package:provider/provider.dart' as provider;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  TabController _tabController;
  ScrollController _scrollController;

  SnackBar _snackBar = SnackBar(
    content: Container(
      alignment: Alignment.centerLeft,
      height: 60,
      child: Text(
        'No internet connection available!',
        style: TextStyle(
          fontSize: 17,
        ),
      ),
    ),
    action: SnackBarAction(
      label: 'Try Again',
      textColor: Colors.blueAccent,
      onPressed: () {},
    ),
  );

  void checkInternet() async {
    final InternetBloc ib = provider.Provider.of<InternetBloc>(context, listen: false);
    await ib.checkInternet();
    ib.hasInternet == false
        ? _scaffoldKey.currentState.showSnackBar(_snackBar)
        : print('Internet is Available');
  }

  @override
  void initState() {
    firebaseMessaging.subscribeToTopic('all');
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        nextScreen(context, NotificationPage());
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );

    Future.delayed(Duration(milliseconds: 0)).then((_) {
      final UserBloc ub = provider.Provider.of<UserBloc>(context, listen: false);
      final BookmarkBloc bb = provider.Provider.of<BookmarkBloc>(context, listen: false);
      
      ub.getUserData();
      bb.getData();
      checkInternet();
      
      

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final NotificationBloc nb = provider.Provider.of<NotificationBloc>(context, listen: false);
    final Shader linearGradient = LinearGradient(
      colors: <Color>[Color(0xffff0000), Color(0xff0000ff)],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 250.0, 150.0));

    return DefaultTabController(
      length: 10,
      child: Scaffold(
        drawer: DrawerMenu(),
        key: _scaffoldKey,
        body:NestedScrollView(
    controller: _scrollController,
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        new SliverAppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          titleSpacing: 0,
          
          title: RichText(
            text: TextSpan(
              text: 'USU ',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: 'Drug',
                    style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.blue[900],
                    ),
                    ),
                TextSpan(
                  text: 'Cards',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.red[900],
                  ),
                )
              ],
            ),
          ),
          leading: IconButton(
            icon: Icon(
              AntDesign.menu_fold,
              size: 20,
              color: Colors.black87,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          elevation: 1,
          
          actions: <Widget>[
            IconButton(
              icon: Icon(
                AntDesign.search1,
                color: Colors.black,
                size: 20,
              ),
              onPressed: () {
                nextScreen(context, SearchPage());
              },
            ),
            Badge(
              position: BadgePosition.topEnd(top: 7, end: 9),
              badgeColor: Colors.redAccent,
              animationType: BadgeAnimationType.fade,
              showBadge: nb.savedNlength < nb.notificationLength ? true : false,
              badgeContent: Text(nb.notificationFinalLength.toString(), style: TextStyle(fontSize: 10, color: Colors.white),),
              child: IconButton(
              icon: Icon(Icons.notifications_none),
              
              onPressed: () {
                nb.saveNlength();
                nextScreen(context, NotificationPage());
              },
            ),
            ),
            SizedBox(width: 5,)
          ],
          pinned: true,
          floating: true,
          forceElevated: innerBoxIsScrolled,
          
          bottom: TabBar(
            //labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.blueAccent[200],
            unselectedLabelColor: Color(0xff5f6368), //niceish grey
            isScrollable: true,
            onTap: (index) {
              checkInternet();
            },
            indicator: MD2Indicator(
                //it begins here
                indicatorHeight: 3,
                indicatorColor: Colors.blueAccent[900],
                indicatorSize:
                    MD2IndicatorSize.normal //3 different modes tiny-normal-full
                ),
            tabs: <Widget>[
              Tab(
                text: "Home",
              ),
              Tab(
                text: categories[0],
              ),
              Tab(
                text: categories[1],
              ),
              Tab(
                text: categories[2],
              ),
              Tab(
                text: categories[3],
              ),
              Tab(
                text: categories[4],
              ),
              Tab(
                text: categories[5],
              ),
                Tab(
                  text: categories[6],
                ),
                Tab(
                  text: categories[7],
                ),
                  Tab(
                  text: categories[8],
                  ),
            ],
          ),
        ),
      ];
    },
    body: WillPopScope(
                onWillPop: (){
                  return SystemNavigator.pop();
                },
                child: TabBarView(
            children: <Widget>[
              Tab0(),
              Tab1(),
              Tab2(),
              Tab3(),
              Tab4(),
              Tab5(),
              Tab6(),
              Tab7(),
              Tab8(),
              Tab9(),
            ],
            controller: _tabController,
          ),
        ),
  ),
        

      ),
    );
  }
}
