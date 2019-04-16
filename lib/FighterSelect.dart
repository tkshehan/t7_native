import 'package:flutter/material.dart';

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
