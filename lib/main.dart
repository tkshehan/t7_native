import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(new MyApp());

Future<String> _loadJsonAsset() async {
  return await rootBundle.loadString('assets/data/data.json');
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    _loadJsonAsset().then(print);
    return new MaterialApp(
        home: new Scaffold(
      appBar: new AppBar(
        title: new Text('JSON to List'),
      ),
      body: new Center(
        child: new Text(
          'Hello World !',
          style: Theme.of(context).textTheme.headline,
        ),
      ),
    ));
  }
}
