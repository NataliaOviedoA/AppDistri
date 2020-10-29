import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TemperaturePage extends StatelessWidget {
  final temperature;
  final humidity;

  const TemperaturePage(
      {Key key, @required this.temperature, @required this.humidity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            children: [
              Text('Temperatura',
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 50),
              SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    backgroundImage:const AssetImage('images/light_frame.png'),
                    minimum: -60,
                    maximum: 120,
                    interval: 20,
                    radiusFactor: 0.5,
                    showAxisLine: false,
                    labelOffset: 5,
                    useRangeColorForAxis: true,
                    axisLabelStyle: GaugeTextStyle(fontWeight: FontWeight.bold),
                    ranges: <GaugeRange>[
                      GaugeRange(
                          startValue: -60,
                          endValue: 120,
                          startWidth: 0.03,
                          sizeUnit: GaugeSizeUnit.factor,
                          endWidth: 0.03,
                          gradient: SweepGradient(stops: <double>[
                            0.2,
                            0.5,
                            0.75
                          ], colors: <Color>[
                            Colors.blue[200],
                            Colors.orange[200],
                            Colors.red[200]
                          ]))
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          widget: Text(
                            '°F',
                            style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          positionFactor: 0.8,
                          angle: 90)
                    ],
                  ),
                  RadialAxis(
                    ticksPosition: ElementsPosition.outside,
                    labelsPosition: ElementsPosition.outside,
                    minorTicksPerInterval: 5,
                    axisLineStyle: AxisLineStyle(
                      thicknessUnit: GaugeSizeUnit.factor,
                      thickness: 0.1,
                    ),
                    axisLabelStyle: GaugeTextStyle(

                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    radiusFactor: 0.97,
                    majorTickStyle: MajorTickStyle(
                        length: 0.1,
                        thickness: 2,

                        lengthUnit: GaugeSizeUnit.factor),
                    minorTickStyle: MinorTickStyle(
                        length: 0.05,
                        thickness: 1.5,

                        lengthUnit: GaugeSizeUnit.factor),
                    minimum: -50,
                    maximum: 50,
                    interval: 10,
                    startAngle: 115,
                    endAngle: 65,
                    ranges: <GaugeRange>[
                      GaugeRange(
                          startValue: -50,
                          endValue: 50,
                          startWidth: 0.1,
                          sizeUnit: GaugeSizeUnit.factor,
                          endWidth: 0.1,
                          gradient: SweepGradient(stops: <double>[
                            0.4,
                            0.65,
                            0.75
                          ], colors: <Color>[
                            Colors.blue[200],
                            Colors.orange[200],
                            Colors.red[200]
                          ]))
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(
                          value: this.temperature, needleColor: Colors.lightBlue,
                          tailStyle: TailStyle(length: 0.18, width: 8,
                              color: Colors.lightBlue,
                              lengthUnit: GaugeSizeUnit.factor),
                          needleLength: 0.68,
                          needleStartWidth: 1,
                          needleEndWidth: 8,
                          knobStyle: KnobStyle(knobRadius: 0.07,
                              color: Colors.white, borderWidth: 0.05,
                              borderColor: Colors.lightBlue),
                          lengthUnit: GaugeSizeUnit.factor)
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          widget: Text(
                            '°C',
                            style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          positionFactor: 0.8,
                          angle: 90)
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50),
              Text('Humedad',
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text('${this.humidity}',
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              )],
          ),
        ),
      )
    );
  }


  // return Container(
  //     child: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Text(
  //             'Temperatura: ${this.temperature}',
  //             style: Theme.of(context).textTheme.headline4,
  //           ),
  //           Text(
  //             'Humedad: ${this.humidity}',
  //             style: Theme.of(context).textTheme.headline4,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
}