import 'package:flutter/material.dart';
import 'Labs/lab01.dart';
import 'Labs/lab02.dart';
import 'Labs/lab03.dart';
import 'Labs/lab04.dart';
import 'Labs/lab05.dart';
import 'Labs/lab06.dart';
import 'Labs/lab07.dart';
import 'Labs/lab08.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics()
        .logEvent(name: 'lab09_launch_the_app', parameters: null);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App by lSenichl',
      navigatorObservers: <NavigatorObserver>[observer],
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: <NavigatorObserver>[observer],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.dark,
          primarySwatch: Colors.green,
          primaryColor: Colors.green,
          accentColor: Colors.green,
          unselectedWidgetColor: Colors.green),
      home: DefaultTabController(
        length: 8,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Lab01'),
                Tab(text: 'Lab02'),
                Tab(text: 'Lab03'),
                Tab(text: 'Lab04'),
                Tab(text: 'Lab05'),
                Tab(text: 'Lab06'),
                Tab(text: 'Lab07'),
                Tab(text: 'Lab08'),
              ],
            ),
            title: Text(
              'Flutter App by lSenichl',
            ),
          ),
          body: TabBarView(
            children: [
              Lab01(),
              Lab02(),
              Lab03(),
              Lab04(),
              Lab05(),
              Lab06(),
              Lab07(),
              Lab08(),
            ],
          ),
        ),
      ),
    );
  }
}
