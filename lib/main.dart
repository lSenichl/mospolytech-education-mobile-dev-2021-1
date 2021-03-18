import 'package:flutter/material.dart';
import 'Labs/lab01.dart';
import 'Labs/lab02.dart';

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
        length: 10,
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
                Tab(text: 'Lab09'),
                Tab(text: 'Lab10'),
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
