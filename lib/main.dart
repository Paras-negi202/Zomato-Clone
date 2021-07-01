// import 'dart:js';

import 'package:flutter/material.dart';
import 'views/search_page_view.dart';
import 'package:provider/provider.dart';
import 'models/app_state.dart';
void main() {
  runApp(Provider(
    create: (context)=>AppState(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SearchPage(title: 'ZomatoClone',),
    );
  }
}


