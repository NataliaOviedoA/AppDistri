import 'package:distrimqtt/src/connection/mqtt_client.dart';
import 'package:flutter/material.dart';

class ControlPage extends StatefulWidget {
  final MqttClientWrapper client;

  const ControlPage({Key key, this.client}) : super(key: key);

  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {

  static const String topic = "AcMain";
  static const String onCommand = "Encender";
  static const String offCommand = "Apagar";

  void _sendMessage(String message) {
    widget.client.publishMessage(topic, message);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          OutlineButton(
            onPressed: () => _sendMessage(onCommand),
            child: Text("Encender"),
          ),
          OutlineButton(
            onPressed: () => _sendMessage(offCommand),
            child: Text("Apagar"),
          ),
        ],
      ),
    );
  }
}