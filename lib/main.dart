import 'package:flutter/material.dart';
import 'Labs/lab01.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
