
import 'package:bmicalculator/data/bmi_model.dart';
import 'package:equatable/equatable.dart';

class BmiState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BmiInitState extends BmiState{

}

class BmiCalculated extends BmiState{

  double bmi;
  bool saved = false;

  BmiCalculated(this.bmi, this.saved);

  @override
  // TODO: implement props
  List<Object?> get props => [bmi, saved];
}
