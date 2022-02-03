

import 'package:bmicalculator/Bloc/height_cubit/height_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeightCubit extends Cubit<HeightState>{

  HeightCubit():super(CMSelected());

  selectCM(){
    emit(CMSelected());
  }

  selectFeet(){
    emit(FeetSelected());
  }
}