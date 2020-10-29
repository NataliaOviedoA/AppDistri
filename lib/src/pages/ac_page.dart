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
  static const String fanCommand = "FAN";
  static const String swingCommand = "SWING";
  static const String masCommand = "MAS";
  static const String menosCommand = "MENOS";
  static const String coolCommand = "Cool";
  static const String heatCommand = "Heat";
  static const String dryCommand = "Dry";

  bool _powerOn = false;

  void _sendMessage(String message) {
    widget.client.publishMessage(topic, message);
  }

  void _powerAcButton() {
    setState(() {
      if (_powerOn) {
        _sendMessage(offCommand);
        _powerOn = false;
      } else {
        _sendMessage(onCommand);
        _powerOn = true;
      }
    });
  }

    String _powerValue() {
      if (_powerOn)
        return "On";
      return "Off";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0XFF2e2e2e),
          ),
          color: Color(0XFF2e2e2e),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        margin: EdgeInsets.only(left: 40, right: 40, bottom: 70, top: 40),
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 40),
            Text(_powerValue(), 
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white54),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ControllerButton(
                  onPressed: this._powerAcButton,
                  child: Icon(
                    Icons.power_settings_new, size: 30, color: Colors.red
                  )
                )
              ],
            ),
            SizedBox(height: 50),
            Expanded(
              child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: ControllerButton(
                        onPressed: (() => _sendMessage(fanCommand)),
                        child: Text(
                          "FAN",
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white54),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: ControllerButton(
                        onPressed: (() => _sendMessage(swingCommand)),
                        child: Text(
                          "SWING",
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white54),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, -0.6),
                      child: ControllerButton(
                        borderRadius: 10,
                        child: Icon(Icons.arrow_drop_up, size: 30, color: Colors.white),
                        onPressed: (() => _sendMessage(masCommand)),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 0.6),
                      child: ControllerButton(
                        borderRadius: 10,
                        child: Icon(Icons.arrow_drop_down, size: 30, color: Colors.white),
                        onPressed: (() => _sendMessage(menosCommand)),
                      ),
                    )
                  ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ControllerButton(
                      borderRadius: 15,
                      child: Text(
                        "Cool",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white54),
                      ),
                      onPressed: (() => _sendMessage(coolCommand)),
                    )
                  ],
                ),
                Column(
                  children: [
                    ControllerButton(
                      borderRadius: 15,
                      child: Text(
                        "Heat",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white54),
                      ),
                      onPressed: (() => _sendMessage(heatCommand)),
                    )
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    ControllerButton(
                      borderRadius: 15,
                      child: Text(
                        "Dry",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white54),
                      ),
                      onPressed: (() => _sendMessage(dryCommand)),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}


class ControllerButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double borderRadius;
  final Color color;
  const ControllerButton({Key key, this.child, this.borderRadius = 30, this.color, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: Color(0XFF2e2e2e),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: [Color(0XFF1c1c1c), Color(0XFF383838)],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0XFF1c1c1c),
            offset: Offset(5.0, 5.0),
            blurRadius: 10.0,
          ),
          BoxShadow(
            color: Color(0XFF404040),
            offset: Offset(-5.0, -5.0),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            gradient: LinearGradient(
              begin: Alignment.topLeft, 
              colors: [Color(0XFF303030), Color(0XFF1a1a1a)]
              ),
          ),
          child: MaterialButton(
            color: color,
            minWidth: 0,
            onPressed: onPressed,
            shape: CircleBorder(),
            child: child,
          ),
        ),
      ),
    );
  }
}