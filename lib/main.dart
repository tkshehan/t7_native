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
  String selectedFighter = 'shaheen';
  var data;
  List fighters;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    _loadJsonAsset().then((result) {
      var data = json.decode(result);
      var keys = List.from(data.keys);
      keys.sort();
      setState(() {
        data = data;
        fighters = keys;
        loaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Tekken 7'),
          ),
          body: Center(
            child: Text('loading'),
          ),
        ),
      );
    } else {
      return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Tekken 7'),
          ),
          body: FighterSelect(fighters, _changeFighter),
        ),
      );
    }
  }

  Future<String> _loadJsonAsset() async {
    return await rootBundle.loadString('assets/data/fighters.json');
  }

  void _changeFighter(String fighter) {
    setState(() {
      selectedFighter = fighter;
    });
    print(selectedFighter);
  }
}

class FighterSelect extends StatelessWidget {
  final List fighters;
  final void Function(String) _changeFighter;

  FighterSelect(this.fighters, this._changeFighter);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(15),
      children: ListTile.divideTiles(
        context: context,
        tiles: _fighterTiles(fighters),
      ).toList(),
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
