import 'package:bmicalculator/Bloc/gender_cubit/gender_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderCubit extends Cubit<GenderState>{

  GenderCubit():super(NoGenderSelected());

  selectMale(){
    emit(MaleSelected());
  }

  selectFemale(){
    emit(FemaleSelected());
  }
}