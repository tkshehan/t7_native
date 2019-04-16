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
  Iterable data;
  bool loaded = false;

  Future<String> _loadJsonAsset() async {
    return await rootBundle.loadString('assets/data/data.json');
  }

  List<Widget> _characterTiles(data) {
    List<Widget> tiles = [];
    data.forEach((character) {
      tiles.add(
        ListTile(
          title: Text(character.toString().toUpperCase()),
        ),
      );
    });
    return tiles;
  }

  @override
  void initState() {
    super.initState();
    _loadJsonAsset().then((result) {
      var keys = List.from(json.decode(result).keys);
      keys.sort();
      print(keys.runtimeType);
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
          title: new Text('JSON to List'),
        ),
        body: ListView(
          padding: EdgeInsets.all(15),
          children: ListTile.divideTiles(
            context: context,
            tiles: _characterTiles(data),
          ).toList(),
        ),
      ));
    }
  }
}

class Character {
  String character;
  List<Attack> attacks;
  List<Grab> grabs;

  Character(
    this.character,
    this.attacks,
    this.grabs,
  );
}

class Attack {
  String command;
  String level;
  String damage;
  String startup;
  String block;
  String hit;
  String counterHit;
  String notes;

  Attack([
    this.command,
    this.level,
    this.damage,
    this.startup,
    this.block,
    this.hit,
    this.counterHit,
    this.notes,
  ]);
}

class Grab {}
