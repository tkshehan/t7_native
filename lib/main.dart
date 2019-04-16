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
  Iterable data;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    _loadJsonAsset().then((result) {
      var keys = List.from(json.decode(result).keys);
      keys.sort();
      setState(() {
        data = keys;
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
              )));
    } else {
      return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Tekken 7'),
          ),
          body: FighterSelect(data, _changeFighter),
        ),
      );
    }
  }

  Future<String> _loadJsonAsset() async {
    return await rootBundle.loadString('assets/data/fighters.json');
  }

  void _changeFighter(String fighter) {
    print(fighter);
    setState(() {
      selectedFighter = fighter;
    });
  }
}

class FighterSelect extends StatelessWidget {
  final Iterable data;
  final void Function(String) _changeFighter;

  FighterSelect(
    this.data,
    this._changeFighter,
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(15),
      children: ListTile.divideTiles(
        context: context,
        tiles: _fighterTiles(data),
      ).toList(),
    );
  }

  List<Widget> _fighterTiles(data) {
    List<Widget> tiles = [];
    data.forEach((fighter) {
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

  _onPressed() {
    _changeFighter(fighter);
  }
}
