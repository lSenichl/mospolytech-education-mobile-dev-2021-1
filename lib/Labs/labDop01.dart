import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class LabDop01 extends StatefulWidget {
  @override
  LabDop01State createState() {
    return LabDop01State();
  }
}

class LabDop01State extends State<LabDop01> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(25),
        child: Center(
            child: ListView(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text('1:', style: TextStyle(fontSize: 18)),
          )
        ])));
  }
}
