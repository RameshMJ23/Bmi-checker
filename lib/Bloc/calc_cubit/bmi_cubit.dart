import 'dart:async';
import 'dart:developer';

import 'package:bmicalculator/Bloc/height_cubit/height_cubit.dart';
import 'package:bmicalculator/Bloc/height_cubit/height_state.dart';
import 'package:bmicalculator/Bloc/weight_cubit/weight_cubit.dart';
import 'package:bmicalculator/Bloc/weight_cubit/weight_state.dart';

import 'bmi_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BMICubit extends Cubit<BmiState>{

  double weight = 0.0;
  double height = 0.0;
  double heightCM = 0.0;
  double heightFeet = 0.0;
  double heightInch = 0.0;

  BMICubit():super(BmiInitState());


  calculate({
    required double age,
  }){

    if(heightInch != 0){
      height = heightInch + heightFeet;
    }else{
      height = heightCM;
    }

    double value_1 = weight/height;
    double bmi = (value_1/height)* 10000.0;
    log(bmi.toString());
    emit(BmiCalculated(bmi, false));
  }

  reset(){
    emit(BmiInitState());
  }

  saved(BmiState state){
    if(state is BmiCalculated){

      emit(BmiCalculated(state.bmi, true));
    }
  }



}