import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

import 'FighterSelect.dart';
import 'Fighter.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map data;
  List fighters;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    _loadJsonAsset().then((result) {
      Map data = json.decode(result);
      List keys = List.from(data.keys);
      keys.sort();
      setState(() {
        data = data;
        fighters = keys;
        loaded = true;
      });
    });
  }

  Future<String> _loadJsonAsset() async {
    return await rootBundle.loadString('assets/data/fighters.json');
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) return LoadingScreen();

    return MaterialApp(
      title: 'Tekken 7',
      // Start the app with the "/" named route. In our case, the app will start
      // on the FirstScreen Widget
      initialRoute: '/',
      routes: {
        // When we navigate to the "/" route, build the FirstScreen Widget
        '/': (context) => FighterSelect(fighters, _changeFighter),
        // When we navigate to the "/second" route, build the SecondScreen Widget
        '/second': (context) => SecondScreen(),
      },
    );
  }

  void _changeFighter(String fighter) {
    print(fighter);
  }
}
