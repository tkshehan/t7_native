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
      body: ListView(
        children: _moveList(args.data),
      ),
    );
  }

  List<Widget> _moveList(data) {
    const Map attackKeys = {
      'Command': 'Command',
      'Level': 'Level',
      'Damage': 'Damage',
      'Startup': 'Startup',
      'Block': 'Block',
      'Hit': 'Hit',
      'CH': 'CH',
    };

    List<Widget> tiles = [];
    tiles.add(Attack(attackKeys));

    data['moves'].forEach(
      (value) => {
            tiles.add(
              Attack(value),
            )
          },
    );
    return tiles;
  }
}

class FighterArguments {
  final String name;
  final Map data;

  FighterArguments(this.name, this.data);
}

class Attack extends StatelessWidget {
  final Map attack;
  Attack(this.attack);

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

    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.black,
        width: 2,
      ))),
      child: Column(
        children: <Widget>[
          _attackRowTop(top[0], top[1], top[2]),
          _attackRowBottom(bottom[0], bottom[1], bottom[2], bottom[3]),
        ],
      ),
    );
  }

  Widget _attackRowTop(String command, String level, String damage) {
    List<Widget> temp = [];

    temp.addAll([
      FlexContainer(command, 2),
      FlexContainer(level, 1),
      FlexContainer(damage, 1),
    ]);

    return Row(
      children: temp,
    );
  }

  Widget _attackRowBottom(String startup, String block, String hit, String ch) {
    List<Widget> temp = [];

    temp.addAll([
      FlexContainer(startup, 1),
      FlexContainer(block, 1),
      FlexContainer(hit, 1),
      FlexContainer(ch, 1),
    ]);

    return Row(
      children: temp,
    );
  }
}

class FlexContainer extends StatelessWidget {
  final String text;
  final int flex;

  FlexContainer(
    this.text,
    this.flex,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: this.flex,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.lightBlueAccent,
          ),
        ),
        child: Center(child: Text(this.text)),
      ),
    );
  }
}
