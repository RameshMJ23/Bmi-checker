import 'package:bmicalculator/Bloc/database_cubit/databse_cubit.dart';
import 'package:bmicalculator/screens/chart_screen.dart';

import 'Bloc/calc_cubit/bmi_cubit.dart';
import 'package:bmicalculator/Bloc/gender_cubit/gender_cubit.dart';
import 'package:bmicalculator/Bloc/height_cubit/height_cubit.dart';
import 'package:bmicalculator/Bloc/weight_cubit/weight_cubit.dart';
import 'package:bmicalculator/screens/main_screen.dart';
import 'package:bmicalculator/screens/saved_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DatabaseCubit(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BMI calculator',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: BlocProvider(
            create: (context) => DatabaseCubit(),
            child: MultiBlocProvider(
              providers:[
                BlocProvider(create: (context) => GenderCubit()),
                BlocProvider(create: (context) => HeightCubit()),
                BlocProvider(create: (context) => WeightCubit()),
                BlocProvider(create: (context) => BMICubit()),
              ],
              child: MainScreen(),
            ),
          )
      ),
    );
  }
}

