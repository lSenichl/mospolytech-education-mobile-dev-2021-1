import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class Lab08 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Lab08State();
}

class _Lab08State extends State<Lab08> {
  final HttpClient client = new HttpClient();

  String token = '';
  String responseText = '';

  Uint8List responseImage;

  Map jsonMap = {'username': 'user1', 'password': 'abcxyz'};

  _Lab08State() {
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
  }

  void getJwt() {
    client
        .postUrl(Uri.parse('https://flutter-jwt-senich.herokuapp.com/auth'))
        .then((HttpClientRequest request) {
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(jsonMap)));
      print(request);
      return request.close();
    }).then((HttpClientResponse response) {
      response.listen((event) {
        String responseString = String.fromCharCodes(event);
        setState(() {
          token = json.decode(responseString)['access_token'];
          print(token);
        });
      });
    });
  }

  void getResp() {
    client
        .getUrl(Uri.parse('https://flutter-jwt-senich.herokuapp.com/protected'))
        .then((HttpClientRequest request) {
      request.headers.set('Authorization', 'JWT $token');
      return request.close();
    }).then((HttpClientResponse response) {
      if (response.statusCode != 200) {
        response.listen((event) {
          String responseString = String.fromCharCodes(event);
          setState(() {
            responseText = responseString;
          });
        });
      } else {
        String gotResponse = '';
        response.forEach((element) {
          gotResponse += String.fromCharCodes(element);
        }).then((value) {
          var jsonDecoded = json.decode(gotResponse);
          String message = jsonDecoded['message'];
          String time = DateFormat.yMd()
              .add_jm()
              .format(DateTime.fromMicrosecondsSinceEpoch(
                  jsonDecoded['timestamp'].toInt() * 1000000))
              .toString();
          setState(() {
            responseText =
                'Сообщение от сервера: $message\nВремя: $time\nФото: ';
            responseImage = base64.decode(jsonDecoded['image']);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 15),
            child: Text(
              'JWT-токен: ',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            )),
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(15),
            child: Text(token, textAlign: TextAlign.left)),
        ElevatedButton(onPressed: getJwt, child: Text('Аутентифицироваться')),
        ElevatedButton(
            onPressed: getResp, child: Text('Получить приватную информацию')),
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 15),
            child: Text(
              'Ответ сервера: ',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            )),
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(12),
            child: Column(
              children: [
                Text(responseText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15)),
                Column(children: [
                  if (responseImage == null)
                    Text('Ответа пока нет :(')
                  else
                    Container(
                        padding: EdgeInsets.only(top: 12),
                        child: FittedBox(
                          child: Image.memory(responseImage),
                          fit: BoxFit.fill,
                        ))
                ]),
              ],
            )),
      ],
    ));
  }
}
