import 'package:flutter/material.dart';
import 'Labs/lab01.dart';
import 'Labs/lab02.dart';
import 'Labs/lab03.dart';
import 'Labs/lab04.dart';
import 'Labs/lab05.dart';
import 'Labs/lab06.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App by lSenichl',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
              Align(
                alignment: Alignment.center,
                child: Text(
                  'В разработке...',
                  textDirection: TextDirection.ltr,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'В разработке...',
                  textDirection: TextDirection.ltr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
