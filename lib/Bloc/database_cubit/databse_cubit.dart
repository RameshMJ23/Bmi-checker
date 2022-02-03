
import 'package:bmicalculator/Bloc/database_cubit/database_state.dart';
import 'package:bmicalculator/data/bmi_database.dart';
import 'package:bmicalculator/data/bmi_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatabaseCubit extends Cubit<DatabaseState>{
  DatabaseCubit():super(DatabaseInit());

  initialDatabase() async{
    emit(InitialDatabase(await fetchDatabase()));
  }

  delete(int id) async{
    await BMIDatabase.instance.delete(id);
    emit(UpdatedDatabase(await fetchDatabase()));
  }

  create(BMIModel bmiModel) async{
    await BMIDatabase.instance.create(bmiModel);
  }

  Future<List<BMIModel>> fetchDatabase() async{
    List<BMIModel> list = await BMIDatabase.instance.readAll();
    return list;
  }
}