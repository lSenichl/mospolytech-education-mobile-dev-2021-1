import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

class WebViewWeather extends StatefulWidget {
  @override
  _WebViewWeatherState createState() => _WebViewWeatherState();
}

class _WebViewWeatherState extends State<WebViewWeather> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: 'https://yandex.ru/pogoda/moscow',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptChannels: <JavascriptChannel>[
            _toasterJavascriptChannel(context),
          ].toSet(),
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}

class Lab03 extends StatefulWidget {
  @override
  Lab03State createState() {
    return Lab03State();
  }
}

class Lab03State extends State<Lab03> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [
    WebViewWeather(),
    HTMLDownload(),
    CelciumDownload(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.open_in_browser),
            label: 'Web View',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.code),
            label: 'HTML',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny),
            label: 'Погода',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HTMLDownload extends StatefulWidget {
  @override
  _HTMLDownloadState createState() => _HTMLDownloadState();
}

class _HTMLDownloadState extends State<HTMLDownload> {
  var val;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 31),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                    child: Icon(Icons.arrow_downward),
                    onPressed: () async {
                      val = await http
                          .get(Uri.https('yandex.ru', 'pogoda/moscow'));
                      val = val.body;
                      setState(() {});
                    }),
              ),
            ),
          ],
        ),
        body: Center(
            child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.9,
                child: val != null
                    ? ListView(children: <Widget>[Html(data: val)])
                    : Center(
                        child: Text("Нажмите кнопку \"Download\" !",
                            style: TextStyle(fontSize: 25))))));
  }
}

class CelciumDownload extends StatefulWidget {
  @override
  _CelciumDownloadState createState() => _CelciumDownloadState();
}

class _CelciumDownloadState extends State<CelciumDownload> {
  var val2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 31),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                    child: Icon(Icons.arrow_downward),
                    onPressed: () async {
                      val2 = await http
                          .get(Uri.https('yandex.ru', 'pogoda/moscow'));
                      dom.Document document = parser.parse(val2.body);
                      var content = document
                          .getElementsByClassName('fact__temp')[0]
                          .getElementsByClassName('temp__value_with-unit')[0]
                          .innerHtml;
                      val2 = content.toString();
                      setState(() {});
                    }),
              ),
            ),
          ],
        ),
        body: Center(
            child: Container(
                child: val2 != null
                    ? Center(
                        child: Text('В Москве: ' + val2 + '°C',
                            style: TextStyle(fontSize: 50)))
                    : Center(
                        child: Text("Нажмите кнопку \"Download\" !",
                            style: TextStyle(fontSize: 25))))));
  }
}
