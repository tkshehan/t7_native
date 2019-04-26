import 'package:flutter/material.dart';

class FighterScreen extends StatelessWidget {
  static const routeName = '/fighter';

  @override
  Widget build(BuildContext context) {
    final FighterArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.name.toUpperCase()),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: _moveList(args.data),
          ),
          Positioned(
            child: _attackKeys(),
          ),
        ],
      ),
    );
  }

  List<Widget> _moveList(data) {
    List<Widget> tiles = [];
    tiles.add(_attackKeys());

    data['moves'].forEach(
      (value) => {
            tiles.add(
              Attack(value, 110),
            )
          },
    );
    return tiles;
  }

  Widget _attackKeys() {
    const Map attackKeys = {
      'Command': 'Command',
      'Level': 'Level',
      'Damage': 'Damage',
      'Startup': 'Startup',
      'Block': 'Block',
      'Hit': 'Hit',
      'CH': 'CH',
    };
    return Attack(attackKeys, 50);
  }
}

class FighterArguments {
  final String name;
  final Map data;

  FighterArguments(this.name, this.data);
}

class Attack extends StatelessWidget {
  final Map attack;
  final double height;
  final double borderWidth = 1;
  Attack(this.attack, this.height);

  @override
  Widget build(BuildContext context) {
    List top = [
      attack['Command'],
      attack['Level'],
      attack['Damage'],
    ];
    List bottom = [
      attack['Startup'],
      attack['Block'],
      attack['Hit'],
      attack['CH'],
      attack['Notes'],
    ];

    return Card(
      child: Container(
        height: height + borderWidth,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
              color: Colors.black,
              width: borderWidth,
            ))),
        child: Column(
          children: <Widget>[
            _attackRowTop(top[0], top[1], top[2]),
            _attackRowBottom(bottom[0], bottom[1], bottom[2], bottom[3]),
          ],
        ),
      ),
    );
  }

  Widget _attackRowTop(String command, String level, String damage) {
    List<Widget> temp = [];

    temp.addAll([
      _flexContainer(command, 2),
      _flexContainer(level, 1),
      _flexContainer(damage, 1),
    ]);

    return Row(
      children: temp,
    );
  }

  Widget _attackRowBottom(String startup, String block, String hit, String ch) {
    List<Widget> temp = [];

    temp.addAll([
      _flexContainer(startup, 1),
      _flexContainer(block, 1),
      _flexContainer(hit, 2),
      _flexContainer(ch, 2),
    ]);

    return Row(
      children: temp,
    );
  }

  Widget _flexContainer(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: EdgeInsets.all(1),
        height: height / 2,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.lightBlueAccent,
          ),
        ),
        child: Center(child: Text(text)),
      ),
    );
  }
}
