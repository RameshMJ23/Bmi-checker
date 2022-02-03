
import 'dart:developer';
import 'package:bmicalculator/Bloc/database_cubit/databse_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Bloc/calc_cubit/bmi_cubit.dart';
import '../Bloc/calc_cubit/bmi_state.dart';
import 'package:bmicalculator/Bloc/gender_cubit/gender_cubit.dart';
import 'package:bmicalculator/Bloc/gender_cubit/gender_state.dart';
import 'package:bmicalculator/Bloc/height_cubit/height_cubit.dart';
import 'package:bmicalculator/Bloc/height_cubit/height_state.dart';
import 'package:bmicalculator/Bloc/weight_cubit/weight_cubit.dart';
import 'package:bmicalculator/Bloc/weight_cubit/weight_state.dart';
import 'package:bmicalculator/data/bmi_database.dart';
import 'package:bmicalculator/data/bmi_model.dart';
import 'package:bmicalculator/model/annotation.dart';
import 'package:bmicalculator/screens/saved_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late double age = 0.0;
  late double height = 0.0;
  late double weight = 0.0;
  late double height1 = 0.0;
  late double height2 = 0.0;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController feetController = TextEditingController();
  TextEditingController inchController = TextEditingController();
  TextEditingController weightController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BMICubit, BmiState>(
      builder: (context, bmiState){
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text("BMI calculator", style: TextStyle(color: Colors.green),),
              backgroundColor: Colors.transparent,
              toolbarHeight: 80.0,
              elevation: 0.0,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0))
              ),
              actions: [
                IconButton(
                  tooltip: "redo",
                  onPressed: (){
                    redo();
                    BlocProvider.of<BMICubit>(context).reset();
                  },
                  icon:const Icon(
                    Icons.replay,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  tooltip: "Saved BMI",
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => SavedScreen()));
                  },
                  icon: const Icon(
                    Icons.save_alt,
                    color: Colors.green,
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    BlocBuilder<GenderCubit, GenderState>(
                      builder: (context, state){
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: (state is MaleSelected)
                                        ? Border.all(color: Colors.black, width: 2.0)
                                        : null
                                ),
                                child: const Icon(
                                  Icons.male_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: (){
                                BlocProvider.of<GenderCubit>(context).selectMale();
                              },
                            ),
                            Expanded(
                              child: Container(
                                width: 50.0,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                                  child: TextFormField(
                                    controller: ageController,
                                    keyboardType: TextInputType.number,
                                    onChanged: (val){
                                      if(val.isNotEmpty) age = double.parse(val);
                                    },
                                    validator: (val) => val!.isEmpty ? "Enter value" : null,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(color: Colors.black)
                                      ),
                                      hintText: "Enter Age ${ageText(state)}",
                                      label: Text("Age ${ageText(state)}", style: TextStyle(color: Colors.black),),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black54,width: 2.0)
                                      )
                                    ),
                                    cursorColor: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: (state is FemaleSelected)
                                        ? Border.all(color: Colors.black, width: 2.0)
                                        : null
                                ),
                                child: Icon(
                                  Icons.female_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: (){
                                BlocProvider.of<GenderCubit>(context).selectFemale();
                              },
                            )
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    BlocBuilder<HeightCubit, HeightState>(
                      builder: (context, state){
                        return Row(
                          children: [
                            GestureDetector(
                              child: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10.0),
                                    border: (state is CMSelected)
                                        ? Border.all(color: Colors.black, width: 2.0)
                                        : null
                                ),
                                child: const Center(
                                  child:  Text(
                                    "Cm",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                              onTap: (){
                                BlocProvider.of<HeightCubit>(context).selectCM();
                              },
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: (state is CMSelected)
                                  ? TextFormField(
                                    controller: heightController,
                                    keyboardType: TextInputType.number,
                                    onChanged: (val){
                                      if(val.isNotEmpty) BlocProvider.of<BMICubit>(context).heightCM = double.parse(val);
                                    },
                                    validator: (val) => val!.isEmpty? "Enter value" : null,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        hintText: "Enter height",
                                        label: const Text("Height(cm)", style: TextStyle(color: Colors.black)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black54,width: 2.0)
                                        )
                                    ),
                                )
                                : Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 5.0),
                                        child: TextFormField(
                                          controller: feetController,
                                          keyboardType: TextInputType.number,
                                          onChanged: (val){
                                            if(val.isNotEmpty) BlocProvider.of<BMICubit>(context).heightFeet = double.parse(val) * 30.48;
                                          },
                                          validator: (val) => val!.isEmpty? "Enter value" : null,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(5.0),
                                              ),
                                              hintText: "Enter feet",
                                              label: const Text("feet", style: TextStyle(color: Colors.black)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.black54,width: 2.0)
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: TextFormField(
                                          controller: inchController,
                                          keyboardType: TextInputType.number,
                                          onChanged: (val){
                                            if(val.isNotEmpty) BlocProvider.of<BMICubit>(context).heightInch = double.parse(val) * 2.54;
                                          },
                                          validator: (val) => val!.isEmpty? "Enter value" : null,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(5.0),
                                              ),
                                              hintText: "Enter inch",
                                              label: const Text("inch", style: TextStyle(color: Colors.black)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.black54,width: 2.0)
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10.0),
                                      border: (state is FeetSelected)
                                          ? Border.all(color: Colors.black, width: 2.0)
                                          : null
                                  ),
                                  child:const Center(
                                    child: Text(
                                      "F+in",
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                    ),
                                  )
                              ),
                              onTap: (){
                                BlocProvider.of<HeightCubit>(context).selectFeet();
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    BlocBuilder<WeightCubit, WeightState>(
                      builder: (context, state){
                        return Row(
                          children: [
                            GestureDetector(
                              child: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: (state is KGState)
                                          ? Border.all(color: Colors.black, width: 2.0)
                                          : null
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Kg",
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                    ),
                                  )
                              ),
                              onTap: (){
                                BlocProvider.of<WeightCubit>(context).selectKG();
                              },
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: TextFormField(
                                  controller: weightController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (val){
                                    if(val.isNotEmpty){
                                      if(state is PoundState){
                                        BlocProvider.of<BMICubit>(context).weight = double.parse(val) * 0.453592;
                                      }else{
                                        BlocProvider.of<BMICubit>(context).weight = double.parse(val);
                                      }
                                    }
                                  },
                                  validator: (val) => val!.isEmpty ? "Enter value" : null ,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      hintText: "Enter weight ${weightText(state)}",
                                      label:Text("Weight ${weightText(state)}", style: TextStyle(color: Colors.black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black54,width: 2.0)
                                      )
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10.0),
                                      border: (state is PoundState)
                                          ? Border.all(color: Colors.black, width: 2.0)
                                          : null
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Lbs",
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                    ),
                                  )
                              ),
                              onTap: (){
                                BlocProvider.of<WeightCubit>(context).selectPounds();
                              },
                            ),
                          ],
                        );
                      }
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: InkWell(
                                child: ElevatedButton(
                                  child: const Text("Calculate"),
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.green)
                                  ),
                                  onPressed: (){
                                    FocusScope.of(context).unfocus();
                                    if(_formKey.currentState!.validate()){
                                      log(weight.toString());
                                      log(height.toString());
                                      log(age.toString());

                                      BlocProvider.of<BMICubit>(context).calculate(
                                        age: age,
                                      );
                                    }
                                  },
                                ),
                                onTap: (){

                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: BlocBuilder<BMICubit, BmiState>(
                                builder: (context,state){
                                  return InkWell(
                                    child: ElevatedButton(
                                      child: Text(
                                        "Save",
                                        style: TextStyle(
                                            color: Colors.green
                                        ),
                                      ),
                                      style: ButtonStyle(
                                          side: MaterialStateProperty.all(BorderSide(color: Colors.green)),
                                          backgroundColor: MaterialStateProperty.all(Colors.white)
                                      ),
                                      onPressed: (){
                                        FocusScope.of(context).unfocus();
                                        if(state is BmiCalculated && state.saved == false){
                                          BlocProvider.of<DatabaseCubit>(context).create(
                                              BMIModel
                                                (
                                                age: age,
                                                height: height,
                                                weight: weight,
                                                bmi: double.parse(state.bmi.toStringAsFixed(1)),
                                                dateTime: DateTime.now(),
                                              )
                                          );
                                          BlocProvider.of<BMICubit>(context).saved(state);
                                          Fluttertoast.showToast(
                                              msg: "Saved",
                                              textColor: Colors.white,
                                              backgroundColor: Colors.green
                                          );
                                        }else if(state is BmiCalculated && state.saved == true){
                                          Fluttertoast.showToast(
                                              msg: "Already saved",
                                              textColor: Colors.white,
                                              backgroundColor: Colors.green
                                          );
                                        }else{
                                          Fluttertoast.showToast(
                                              msg: "Calculate BMI",
                                              textColor: Colors.white,
                                              backgroundColor: Colors.green
                                          );
                                        }
                                      },
                                    ),
                                    onTap: (){

                                    },
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<BMICubit, BmiState>(
                        builder: (context, state){
                          
                          double bmi;
                          if(state is BmiCalculated){
                            bmi = state.bmi;
                          }else{
                            bmi = 0.0;
                          }
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
                                    needleColor: (state is BmiCalculated)? Colors.black : Colors.transparent
                                  )
                                ],
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(
                                    widget: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        BlocBuilder<BMICubit,BmiState>(
                                          builder: (context, state){
                                            return Text(
                                                (bmi != 0) ? bmi.toStringAsFixed(1) : "Check BMI",
                                              style: TextStyle(
                                                color: showBmi(bmi).color
                                              ),
                                            );
                                          },
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
                        },
                
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  redo(){
    ageController.clear();
    heightController.clear();
    weightController.clear();
    feetController.clear();
    inchController.clear();
  }
  
  //for bmi color
  Annotation showBmi(double bmi){
    if(bmi > 0 && bmi < 17){
      return Annotation(
        color: Colors.blue,
        bmiStatus: "Severely underweight!"
      );

    }else if(bmi >= 17.0 && bmi <= 18.4){
      return Annotation(
        color: Colors.deepPurple,
        bmiStatus: "Underweight"
      );

    }else if(bmi > 18.5 && bmi < 25.0){
      return Annotation(
          color: Colors.green,
          bmiStatus: "Normal"
      );

    }else if(bmi >= 25.0 && bmi < 30.0){
      return Annotation(
          color: Colors.redAccent,
          bmiStatus: "Overweight"
      );
    }else if(bmi >= 30.0){
      return Annotation(
          color: Colors.red,
          bmiStatus: "Obese!"
      );
    }else{
      return Annotation(
          color: Colors.black,
          bmiStatus: ""
      );
    }
  }

  String ageText(GenderState state){
    if(state is NoGenderSelected){
      return "";
    }else if(state is MaleSelected){
      return "(M)";
    }else if(state is FemaleSelected){
      return "(F)";
    }else{
      return "";
    }
  }

  String weightText(WeightState state){
    if(state is KGState){
      return "(Kg)";
    }else if(state is PoundState){
      return "(Lbs)";
    }else{
      return "";
    }
  }
}