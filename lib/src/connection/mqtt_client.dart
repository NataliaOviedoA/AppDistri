import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

enum MqttCurrentConnectionState {
  IDLE,
  CONNECTING,
  CONNECTED,
  DISCONNECTED,
  ERROR_WHEN_CONNECTING
}

enum MqttSubscriptionState { IDLE, SUBSCRIBED }

class MqttClientWrapper {
  static const HOST = "192.168.0.103";
  static const PORT = 1883;
  static const CLIENT = "Client-esp8266";

  MqttClient client;
  MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.IDLE;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;

  final Function(String, String) onMessageReceived;
  final VoidCallback onConnectedCallback;

  MqttClientWrapper(this.onConnectedCallback, this.onMessageReceived);

  void prepareMqttClient(List topics) async {
    _initMqttClient();
    await _connectClient();
    topics.forEach((element) {
      _subscribeToTopic(element);
    });
  }

  void _initMqttClient() {
    client = MqttServerClient.withPort(HOST, CLIENT, PORT);
    client.logging(on: true);
    client.keepAlivePeriod = 20;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;
    client.onDisconnected = _onDisconnected;
  }

  Future<void> _connectClient() async {
    try {
      print('Conectando al servidor');
      connectionState = MqttCurrentConnectionState.CONNECTING;
      await client.connect();
    } on Exception catch (e) {
      print('ERROR: Excepción en conexión - $e');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }

    if (client.connectionStatus.state == MqttConnectionState.connected) {
      connectionState = MqttCurrentConnectionState.CONNECTED;
      print('Se conecto al servidor');
    } else {
      print('ERROR: Conexión fallida - desconectado');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }
  }

  void _subscribeToTopic(String topicName) {
    print('Topico: "$topicName"');
    client.subscribe(topicName, MqttQos.atMostOnce);
    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      c.forEach((element) {
        final MqttPublishMessage receivedMessage = element.payload;
        final String message = MqttPublishPayload.bytesToStringAsString(
            receivedMessage.payload.message);
        onMessageReceived(element.topic, message);
      });
    });
  }

  void publishMessage(String topic, String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);

    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload);
  }

  void _onDisconnected() {
    print('Cliente desconectado');
    if (client.connectionStatus.returnCode ==
        MqttConnectReturnCode.brokerUnavailable) {
      print('OnDisconnected callback is solicited, this is correct');
    }
    connectionState = MqttCurrentConnectionState.DISCONNECTED;
  }

  void _onSubscribed(String topic) {
    print('Suscripción existosa a "$topic"');
    subscriptionState = MqttSubscriptionState.SUBSCRIBED;
  }

  void _onConnected() {
    connectionState = MqttCurrentConnectionState.CONNECTED;
    print('Cliente conectado exitosamente');
    onConnectedCallback();
  }
}