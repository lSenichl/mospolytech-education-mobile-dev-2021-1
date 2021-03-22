import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

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
          Scaffold.of(context).showSnackBar(
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
    JSONDownload(),
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

class JSONDownload extends StatefulWidget {
  @override
  _JSONDownloadState createState() => _JSONDownloadState();
}

class _JSONDownloadState extends State<JSONDownload> {
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
                      val = await http.get(Uri.https('api.openweathermap.org',
                          '/data/2.5/weather?q=Moscow&appid=3f78296e6ab83804e411f607927df45f'));
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
