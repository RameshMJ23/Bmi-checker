
import 'package:bmicalculator/Bloc/weight_cubit/weight_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeightCubit extends Cubit<WeightState>{

  WeightCubit():super(KGState());

  selectKG(){
    emit(KGState());
  }

  selectPounds() {
    emit(PoundState());
  }
}