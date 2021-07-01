import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class Restaurant_View extends StatefulWidget {
  Restaurant_View({this.url});
  final String url;
  @override
  _Restaurant_ViewState createState() => _Restaurant_ViewState();
}

class _Restaurant_ViewState extends State<Restaurant_View> {
  String finalUrl;
  final Completer<WebViewController> _controller=Completer<WebViewController>();


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    if(widget.url.contains("http://")){
      finalUrl=widget.url.replaceAll("http://", "https://");
    }
    else{
      finalUrl=widget.url;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 16),
            // color: Colors.red,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [const Color(0xff213A50), const Color(0xff071930)]),
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Restaurant",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "App",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width,
              child: WebView(
                initialUrl: finalUrl,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webviewcontroller){
                  setState(() {
                    _controller.complete(webviewcontroller);
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
