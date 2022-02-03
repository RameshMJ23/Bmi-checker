
import 'package:bmicalculator/data/bmi_model.dart';
import 'package:equatable/equatable.dart';

class DatabaseState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class DatabaseInit extends DatabaseState{

}

class InitialDatabase extends DatabaseState{
  List<BMIModel> initialList;

  InitialDatabase(this.initialList);


  @override
  // TODO: implement props
  List<Object?> get props => [initialList];
}

class UpdatedDatabase extends DatabaseState{

  List<BMIModel> list;

  UpdatedDatabase(this.list);

  @override
  // TODO: implement props
  List<Object?> get props => [list];
}