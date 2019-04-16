import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

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

class FighterSelect extends StatelessWidget {
  final List fighters;
  final void Function(String) _changeFighter;

  FighterSelect(this.fighters, this._changeFighter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tekken 7'),
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: ListTile.divideTiles(
          context: context,
          tiles: _fighterTiles(fighters),
        ).toList(),
      ),
    );
  }

  List<Widget> _fighterTiles(fighters) {
    List<Widget> tiles = [];
    fighters.forEach((fighter) {
      tiles.add(
        FighterTile(fighter.toString(), _changeFighter),
      );
    });
    return tiles;
  }
}

class FighterTile extends StatelessWidget {
  final String fighter;
  final void Function(String) _changeFighter;
  FighterTile(this.fighter, this._changeFighter);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(fighter.toString().toUpperCase()),
      onTap: _onPressed,
    );
  }

  void _onPressed() {
    _changeFighter(fighter);
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Tekken 7"),
        ),
        body: Center(
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
