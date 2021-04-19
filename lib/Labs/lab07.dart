import 'dart:convert';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Lab07 extends StatefulWidget {
  Lab07({Key key, this.title}) : super(key: key);
  final String title;
  @override
  Lab07State createState() => Lab07State();
}

class Lab07State extends State<Lab07> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  List<String> _data = [];
  static const String BOT_URL =
      "https://flutter-chatbot-senich.herokuapp.com/bot";
  TextEditingController _queryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: AnimatedList(
                key: _listKey,
                initialItemCount: _data.length,
                itemBuilder:
                    (BuildContext context, int index, Animation animation) {
                  return _buildItem(_data[index], animation, index);
                }),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextField(
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.message,
                    color: Colors.greenAccent,
                  ),
                  hintText: "Сообщение",
                ),
                controller: _queryController,
                textInputAction: TextInputAction.send,
                onSubmitted: (msg) {
                  this._getResponse();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  http.Client _getClient() {
    return http.Client();
  }

  void _getResponse() {
    if (_queryController.text.length > 0) {
      this._insertSingleItem(_queryController.text);
      var client = _getClient();
      try {
        client.post(
          BOT_URL,
          body: {"query": _queryController.text},
        )..then((response) {
            Map<String, dynamic> data = jsonDecode(response.body);
            _insertSingleItem(data['response'] + "<bot>");
          });
      } catch (e) {
        print("Failed -> $e");
      } finally {
        client.close();
        _queryController.clear();
      }
    }
  }

  void _insertSingleItem(String message) {
    _data.add(message);
    _listKey.currentState.insertItem(_data.length - 1);
  }

  Widget _buildItem(String item, Animation animation, int index) {
    bool mine = item.endsWith("<bot>");
    return SizeTransition(
        sizeFactor: animation,
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Container(
              alignment: mine ? Alignment.topLeft : Alignment.topRight,
              child: Bubble(
                child: Text(item.replaceAll("<bot>", "")),
                color: mine ? Colors.blue : Colors.indigo,
                padding: BubbleEdges.all(10),
              )),
        ));
  }
}
