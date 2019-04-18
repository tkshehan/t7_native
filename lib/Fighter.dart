import 'package:flutter/material.dart';

class FighterScreen extends StatelessWidget {
  static const routeName = '/fighter';

  @override
  Widget build(BuildContext context) {
    final FighterArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.name),
      ),
      body: Center(
        child: Text(args.data.toString()),
      ),
    );
  }
}

class FighterArguments {
  final String name;
  final Map data;

  FighterArguments(this.name, this.data);
}
