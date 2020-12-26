import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/blocs/bookmark_bloc.dart';
import 'package:news_app/blocs/comments_bloc.dart';
import 'package:news_app/blocs/internet_bloc.dart';
import 'package:news_app/blocs/news_data_bloc.dart';
import 'package:news_app/blocs/notification_bloc.dart';
import 'package:news_app/blocs/popular_bloc.dart';
import 'package:news_app/blocs/recent_bloc.dart';
import 'package:news_app/blocs/recommanded_bloc.dart';
import 'package:news_app/blocs/sign_in_bloc.dart';
import 'package:news_app/blocs/user_bloc.dart';
import 'package:news_app/pages/bottom.dart';
import 'package:news_app/pages/sign_up.dart';
import 'package:provider/provider.dart' as provider;

import 'blocs/obstetrics_data_bloc.dart';

//void main() => runApp(MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider<SignInBloc>(
          create: (context) => SignInBloc(),
        ),
        provider.ChangeNotifierProvider<NewsDataBloc>(
          create: (context) => NewsDataBloc(),
          lazy: false,
        ),
        provider.ChangeNotifierProvider<PopularDataBloc>(
          create: (context) => PopularDataBloc(),
        ),
        provider.ChangeNotifierProvider<RecentDataBloc>(
          create: (context) => RecentDataBloc(),
        ),
        provider.ChangeNotifierProvider<ObstetricsDataBloc>(
          create: (context) => ObstetricsDataBloc(),
        ),
        provider.ChangeNotifierProvider<RecommandedDataBloc>(
          create: (context) => RecommandedDataBloc(),
        ),
        provider.ChangeNotifierProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
        provider.ChangeNotifierProvider<BookmarkBloc>(
          create: (context) => BookmarkBloc(),
          lazy: false,
        ),
        provider.ChangeNotifierProvider<CommentsBloc>(
          create: (context) => CommentsBloc(),
        ),
        provider.ChangeNotifierProvider<NotificationBloc>(
          create: (context) => NotificationBloc(),
          lazy: false,
        ),
        provider.ChangeNotifierProvider<InternetBloc>(
          create: (context) => InternetBloc(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.white,
            fontFamily: 'Poppins',
            appBarTheme: AppBarTheme(
                color: Colors.white,
                brightness:
                    Platform.isAndroid ? Brightness.dark : Brightness.light,
                iconTheme: IconThemeData(color: Colors.black87),
                textTheme: TextTheme(
                    headline6: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[900],
                ))),
          ),
          home: MyHomePage()),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignInBloc sb = provider.Provider.of<SignInBloc>(context);
    return sb.isSignedIn == false ? SignUpPage() : BottomWidget();
  }
}
