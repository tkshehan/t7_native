import 'package:flutter/material.dart';

class FighterSelectScreen extends StatelessWidget {
  final List fighters;
  final void Function(BuildContext, String) _changeFighter;

  FighterSelectScreen(this.fighters, this._changeFighter);

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
  final void Function(BuildContext, String) _changeFighter;
  FighterTile(this.fighter, this._changeFighter);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(fighter.toString().toUpperCase()),
      onTap: () {
        _changeFighter(context, fighter);
      },
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
          child: Text('Loading'),
        ),
      ),
    );
  }
}