import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

/*
Widget gaugeWidget(){
  return SfRadialGauge(
    axes: <RadialAxis>[
      RadialAxis(
        minimum: 0,
        maximum: 40,
        canScaleToFit: true,
        ranges: <GaugeRange>[
          GaugeRange(startValue: 0, endValue: 16.9, color: Colors.blue,),
          GaugeRange(startValue: 17.0, endValue: 18.4, color: Colors.deepPurple,),
          GaugeRange(startValue: 18.5, endValue: 24.9, color: Colors.green,),
          GaugeRange(startValue: 25.0, endValue: 29.9, color: Colors.redAccent,),
          GaugeRange(startValue: 30, endValue: 40, color: Colors.red,)
        ],
        pointers: <GaugePointer>[
          NeedlePointer(
            value: bmi,
            enableAnimation: true,
          )
        ],
        annotations: <GaugeAnnotation>[
          GaugeAnnotation(
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  bmi.toStringAsFixed(1),
                  style: TextStyle(
                      color: showBmi(bmi).color
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  showBmi(bmi).bmiStatus,
                  style: TextStyle(
                      color: showBmi(bmi).color
                  ),
                ),
              ],
            ),
            angle: 90,
            positionFactor: 0.5,
          )
        ],
      ),
    ],
  );
}*/
