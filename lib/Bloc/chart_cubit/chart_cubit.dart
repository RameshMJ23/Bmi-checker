

import 'dart:developer';

import 'package:bmicalculator/Bloc/chart_cubit/chart_state.dart';
import 'package:bmicalculator/data/bmi_database.dart';
import 'package:bmicalculator/data/bmi_model.dart';
import 'package:bmicalculator/model/chart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ChartCubit extends Cubit<ChartState>{

  ChartCubit():super(InitChart());

  getValue() async{
    List<BMIModel> list = await BMIDatabase.instance.readAll();
    int blue = 0;
    int deepPurple = 0;
    int green = 0;
    int redAccent = 0;
    int red = 0;
    int totalValue = list.length;
    List<ChartModel> chartData = [];

    log("From ChartCubit:  ${list.length}");

    list.map((e){
      log(e.bmi.toString());
      if(e.bmi > 0 && e.bmi < 17){
        blue++;
        log("blue value found");
      }else if(e.bmi >= 17.0 && e.bmi <= 18.4){
        deepPurple++;
        log("deepPurple value found");

      }else if(e.bmi > 18.5 && e.bmi < 25.0){
        green++;
        log("green value found");

      }else if(e.bmi >= 25.0 && e.bmi < 30.0){
        redAccent++;
        log("redAcc value found");

      }else if(e.bmi >= 30.0){
        red++;
        log("red value found");

      }else{

      }
    }).toList();

    log(blue.toString());
    log(green.toString());
    log(deepPurple.toString());
    log(red.toString());
    log(redAccent.toString());

    chartData = [
      ChartModel(color: Colors.blue, name: "Severely underweight", percentage: percentage(blue, totalValue)),
      ChartModel(color: Colors.deepPurple, name: "Underweight", percentage: percentage(deepPurple, totalValue)),
      ChartModel(color: Colors.green, name: "Normal", percentage: percentage(green, totalValue)),
      ChartModel(color: Colors.redAccent, name: "Overweight", percentage: percentage(redAccent, totalValue)),
      ChartModel(color: Colors.red, name: "Obese", percentage: percentage(red, totalValue)),
    ];

    emit(ChartLoaded(chartData));
  }

  double percentage(int percent, int totalNumber){
    return (percent/totalNumber)*100;
  }

}