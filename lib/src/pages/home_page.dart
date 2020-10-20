import 'package:distrimqtt/src/connection/mqtt_client.dart';
import 'ac_page.dart';
import 'temperature_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Constants
  static const _temperatureTopic = "temperature";
  static const _humidityTopic = "humidity";
  static const _commandTopic = "AcMain";
  static const _topics = [
    _temperatureTopic,
    _humidityTopic,
    _commandTopic,
  ];

  // Variables
  int _selectedItem = 0;
  double _humidity = 0.0;
  double _temperature = 0.0;
  MqttClientWrapper _client;

  // Functions
  _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
    });
  }
  void _afterConnect() {
    print("Se conecto");
  }

  void _newMessage(String topic, String message) {
    print("Message -> $topic: $message");
    setState(() {
      switch (topic) {
        case _temperatureTopic:
          _temperature = double.parse(message);
          break;
        case _humidityTopic:
          _humidity = double.parse(message);
          break;
        default:
          break;
      }
    });
  }

  // Overrides
  @override
  void initState() {
    _client = MqttClientWrapper(
        () => _afterConnect(), (topic, message) => _newMessage(topic, message));
    _client.prepareMqttClient(_topics);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: _selectedItem == 0
          ? TemperaturePage(
              humidity: _humidity,
              temperature: _temperature,
            )
          : ControlPage(client: _client,),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny),
            title: Text("Temperatura"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outline),
            title: Text("Aire Acondicionado"),
          )
        ],
        currentIndex: _selectedItem,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).primaryColor,
      ),
    );
  }
}