import 'package:flutter/material.dart';

class TemperaturePage extends StatelessWidget {
  final temperature;
  final humidity;

  const TemperaturePage(
      {Key key, @required this.temperature, @required this.humidity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Temperatura: ${this.temperature}',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Humedad: ${this.humidity}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}